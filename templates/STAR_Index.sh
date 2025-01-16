#!/bin/bash

set -euo pipefail

# CHECKS
echo ""

# Run the cluster command
echo "Running STAR Index"

mkdir \$PWD/GenomeDir

# Module Load
ml STAR/2.7.11b-GCC-13.2.0

STAR --runThreadN 16 \
		--runMode genomeGenerate \
		--genomeDir \$PWD/GenomeDir \
		--genomeFastaFiles $fasta \
		--sjdbGTFfile $gtf

echo "STAR Indexing Complete"
