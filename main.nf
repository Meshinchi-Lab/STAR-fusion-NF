#!/usr/bin/env nextflow

// Using DSL2 
nextflow.enable.dsl=2

// Define message for the process logs
log.info """\
         R N A S E Q - F U S I O N  P I P E L I N E
         ==========================================
         transcriptome: ${params.star_genome_lib}
         samples      : ${params.sample_sheet}
         """
         .stripIndent()

// Function which prints help message text
def helpMessage() {
    log.info"""

Usage:

nextflow run Meshinchi-Lab/STAR-fusion-NF <ARGUMENTS> OR

sbatch run_main.sh

Required Arguments:
         --sample_sheet        Single file with the location of the input data. Format is a CSV with columns: Sample, R1, R2

Input Data:

Reference Data:
         --star_genome_lib     The location of the CTAT Resource Library for STAR-Fusion - See https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/ for available ones
         --fasta_file          Location of directory which contains the reference genome fasta file (single file) for the optional STAR fusion index step
         --gtf_url             URL of the gtf file for the optional STAR index step - for example on gencode FTP "ftp.ebi.ac.uk/pub/databases/gencode/"

Output Locations:
         --STAR_Fusion_out
         --multiQC_out
         --star_index_out
         --STAR_aligner_out

""".stripIndent()
}

// Import Sub-workflows
include { fastqc } from './modules/fastqc'
include { multiqc } from './multiqc'
include { STAR_Index } from './STAR_Index'
include { STAR_Align } from './modules/STAR_Align'
include { STAR_Fusion } from './modules/STAR_Fusion'

// Channel Definition

// Main Workflow
workflow {

         // Run FASTQC on the Read_1, Read_2 Sample pairs
         fastqc(fqs_ch)
         
         // Run MULTIQC on the Read_1, Read_2 Sample pairs

         //

         //

         //

}


