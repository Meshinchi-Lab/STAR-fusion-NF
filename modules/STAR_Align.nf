#!/usr/bin/env nextflow

// Using DSL-2
nextflow.enable.dsl=2

// 
process STAR_Aligner {
    conda ''
    
    tag ""

    input:
    

    output:
    

    script:
    template 'STAR_Align.sh'

}
