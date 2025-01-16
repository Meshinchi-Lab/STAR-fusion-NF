// Run fastQC to check each input fastq for quality metrics
// from nextflow training April 2020 at Fred Hutch, Seattle WA
process fastqc {

    //use image on quay.io
    container "quay.io/biocontainers/fastqc:0.11.9--hdfd78af_1"
    cpus 2
    memory "16 GB"

    // if process fails, retry running it
    errorStrategy "retry"

    input:
    tuple val(Sample), file(R1), file(R2)

    output:
    path "fastqc_${Sample}_logs"

    script:
    """
    mkdir fastqc_${Sample}_logs
    fastqc -o fastqc_${Sample}_logs -t 6 -f fastq -q $R1 $R2
    #rm $R1 $R2 to avoid repetitive upload to the S3 bucket
    """
}
