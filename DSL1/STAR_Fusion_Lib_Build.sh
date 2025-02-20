#!/bin/bash
set -e
BASE_BUCKET="s3://fh-pi-meshinchi-s-eco-public"


# Load the module
# ml nextflow/19.11.0-edge
ml nextflow/20.04.0-edge


#Execute the next flow workflow
nextflow run -c ~/nextflow.config STAR_Fusion_Genome_Lib.nf \
    --inputs  sample_sheets/Canis_lupus_familiaris_genome_refs_v2.txt \
    --output_folder  $BASE_BUCKET/Reference_Data/CanFam3.1_Ensembl_v103_CTAT_lib/ \
    -with-report STAR-Fusion_Genome_Build_CanisFamiliaris_report.html \
    -cache  TRUE \
    -resume
