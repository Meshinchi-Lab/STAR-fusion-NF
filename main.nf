nextflow.enable.dsl=2

//Define message for the process logs.
log.info """\
         R N A S E Q - F U S I O N  P I P E L I N E
         ===================================
         transcriptome: ${params.star_genome_lib}
         transcriptome: ${params.cicero_genome_lib}
         samples      : ${params.sample_sheet}
         """
         .stripIndent()


include {
        unzip as gunzip_fasta
        unzip as gunzip_gtf } from './modules/fusion-processes.nf'

include { STAR_Fusion; 
        fastqc; 
        multiqc; 
        STAR_index; 
        STAR_aligner; 
        CICERO } from './modules/fusion-processes.nf'

// Function which prints help message text
def helpMessage() {
    log.info"""
Usage:
nextflow run jennylsmith/STAR-fusion-NF <ARGUMENTS>
Required Arguments:
  Input Data:
  --sample_sheet        Single file with the location of all input data. Must be formatted
                        as a CSV with columns: Sample,R1,R2
  Reference Data:
  --star_genome_lib     The location of the CTAT Resource Library for STAR-Fusion - See https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/ for available ones
  --cicero_genome_lib   The location of the References for CICERO Fusion - See https://github.com/stjude/CICERO#reference for available references.
  
  Optional Arguments:
  --fasta_file          Location of directory which contains the reference genome fasta file (single file) for the optional STAR fusion index step
  --gtf_url             URL of the gtf file for the optional STAR index step - for example on gencode FTP "ftp.ebi.ac.uk/pub/databases/gencode/"
  
  Output Locations:
  --STAR_Fusion_out
  --multiQC_out
  --star_index_out
  --STAR_aligner_out
 """.stripIndent()
}

//Workflow to create an index for STAR-aligner given a human genome fasta and the URL location of the GTF file. 
workflow star_index {
    //Download and stage the GTF file from a given URL 
    Channel.fromPath(params.gtf_url)
        .ifEmpty { error  "No file found at URL ${params.gtf_url}" }
        .set{gtf}    
     //if gtf is gzipped, it must be decompressed   
    if(params.gtf_url.endsWith(".gz")){
        gunzip_gtf(gtf)
        gunzip_gtf.out.unzipped_file.set{gtf}
    } 
    //Stage the genome fasta files for the index building step
    Channel.fromPath(params.fasta_file)
        .ifEmpty { error "No files found matching the pattern ${params.fasta_file}." }
        .set{fasta}
    // if fasta  is gzipped, it must be decompressed   
    if(params.fasta_file.endsWith(".gz")){
        gunzip_fasta(fasta)
        gunzip_fasta.out.unzipped_file.set{fasta}
    } 
    //if genome fasta channel filtered to gzipped files is empty (therefore 0 gzipped fasta files prensent)
    //fasta_pattern = "${params.genome_dir}/*.{fa,fasta,fa.gz,fasta.gz}"
    //check = fasta.filter( ~/^.+gz/ ).ifEmpty{ 'EMPTY' } =~ 'EMPTY' ? "not_gzipped" : "gzipped"
    //if( check ==~ 'gzipped' ){
    //     gunzip_fasta(fasta)
    //     gunzip_fasta.out.unzipped_file.set{fasta}
    // }
 
    //Call STAR genomeGenerate to build the index
    STAR_index(fasta, gtf)
}

workflow  fusion_calls {
	// Define the input paired fastq files in a sample sheet and genome references.
	//The sample_sheet is tab separated with column names "Sample","R1","R2"
	fqs_ch = Channel.fromPath(file(params.sample_sheet))
				.splitCsv(header: true, sep: '\t')
				.map { sample -> [sample["Sample"] + "_", file(sample["R1"]), file(sample["R2"])]}

	//processes are treated like functions
    STAR_Fusion(params.star_genome_lib, fqs_ch)

    //run QC on the fastq files
    fastqc(fqs_ch)
    sample_sheet=file(params.sample_sheet)
    multiqc(fastqc.out.collect(), sample_sheet.simpleName)

    STAR_aligner(params.star_index_out, fqs_ch)

    //CICERO requires GRCh37-lite aligned BAMs, so dependent on STAR-aligner BAM 
    STAR_aligner.out.BAM
        .map { BAM  -> [BAM.baseName.split(/_Aligned.+/)[0], file(BAM)] }
        .set { bam_ch }

    //Run CICERO on the STAR-aligner BAM files.
    CICERO(params.cicero_genome_lib, bam_ch)
}