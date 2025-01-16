#!/bin/bash

set -euo pipefail

# CHECKS

# Run the cluster command
echo "Running fastqc"

mkdir fastqc_${Sample}_logs
fastqc -o fastqc_${Sample}_logs -t 6 -f fastq -q $R1 $R2
#rm $R1 $R2 to avoid repetitive upload to the S3 bucket
