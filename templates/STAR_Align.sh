#!/bin/bash

set -euo pipefail

# CHECKS
echo ""

# Run the cluster command
echo "Running STAR Align"

# Module Load
ml STAR/2.7.11b-GCC-13.2.0

STAR --runMode alignReads \
    	--genomeDir \$PWD/$genome_lib/ref_genome.fa.star.idx \
		--runThreadN 8 \
		--readFilesIn $R1 $R2 \
		--outFileNamePrefix $Sample \
		--outReadsUnmapped None \
		--twopassMode Basic \
		--twopass1readsN -1 \
		--readFilesCommand "gunzip -c" \
		--outSAMunmapped Within \
		--outSAMtype BAM SortedByCoordinate \
		--limitBAMsortRAM 63004036730 \
		--outSAMattributes NH HI NM MD AS nM jM jI XS \
		--chimSegmentMin 12 \
		--chimJunctionOverhangMin 12 \
		--chimOutJunctionFormat 1 \
		--alignSJDBoverhangMin 10 \
		--alignMatesGapMax 100000 \
		--alignIntronMax 100000 \
		--alignSJstitchMismatchNmax 5 -1 5 5 \
		--outSAMattrRGline ID:GRPundef \
		--chimMultimapScoreRange 3 \
		--chimScoreJunctionNonGTAG -4 \
		--chimMultimapNmax 20 \
		--chimNonchimScoreDropMin 10 \
		--peOverlapNbasesMin 12 \
		--peOverlapMMp 0.1 \
		--chimFilter banGenomicN
