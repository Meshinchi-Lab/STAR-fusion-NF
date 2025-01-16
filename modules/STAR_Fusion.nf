#!/usr/bin/env nextflow

// Using DSL-2
nextflow.enable.dsl=2

// 
process STAR_Fusion {
    conda '/home/lwallac2/.conda/envs/STAR_Fusion_NF'
    
    tag ""

    input:
    

    output:
    

    script:
    template 'STAR_Fusion.sh'

}
