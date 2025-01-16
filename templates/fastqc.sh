#!/bin/bash

set -euo pipefail

# Run the cluster command
echo "Running FASTQC on $Sample"

# Module Load
ml FastQC/0.12.1-Java-11

# Make a directory for the files
mkdir fastqc_${Sample}_logs

# Run FASTQC on each of R1 and R2 of Sample
fastqc -o fastqc_${Sample}_logs \
    -t 6 \
    -f fastq \
    -q $R1 $R2

#rm $R1 $R2 to avoid repetitive upload to the S3 bucket

echo "FASTQC Complete for $Sample"
