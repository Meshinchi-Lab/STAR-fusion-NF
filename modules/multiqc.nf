#!/usr/bin/env nextflow

// Using DSL-2
nextflow.enable.dsl=2

// 
process multiqc {
    conda ''
    
    tag ""

    input:
    path bam

    output:
    path()

    script:
    template 'multiqc.sh'

}
