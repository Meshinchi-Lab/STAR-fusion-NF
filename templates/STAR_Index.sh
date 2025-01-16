#!/bin/bash

set -euo pipefail

# CHECKS
echo ""

# Run the cluster command
echo "Running STAR Index"

mkdir \$PWD/GenomeDir

STAR --runThreadN 16 \
		--runMode genomeGenerate \
		--genomeDir \$PWD/GenomeDir \
		--genomeFastaFiles $fasta \
		--sjdbGTFfile $gtf

echo "STAR Indexing Complete"
