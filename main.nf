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

Input Data:

Reference Data:

Output Data:

Optional Arguments:

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
         multiqc(fqs_ch)

         //

         //

         //

}


