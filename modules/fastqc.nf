#!/usr/bin/env nextflow

// Using DSL-2
nextflow.enable.dsl=2

// Run fastQC to check each input fastq for quality metrics
process fastqc {

    input:
    tuple val(Sample), file(R1), file(R2)

    output:
    path "fastqc_${Sample}_logs"

    script:
    template 'fastqc.sh'
}
