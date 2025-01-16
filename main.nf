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

