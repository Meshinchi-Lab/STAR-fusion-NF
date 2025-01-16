#!/bin/bash

set -euo pipefail

# CHECKS
echo ""

# Run the STAR Fusion Command
echo "Running STAR Fusion"

# Load STAR-Fusion Module
ml STAR-Fusion/1.12.0-foss-2022b

STAR-Fusion --genome_lib_dir \$PWD/$genome_lib \
	  	--chimeric_junction "${Sample}Chimeric.out.junction" \
		--left_fq $R1 \
		--right_fq $R2 \
	  	--CPU 8 \
	  	--FusionInspector inspect \
	  	--examine_coding_effect \
	  	--denovo_reconstruct \
	  	--output_dir $Sample

echo "STAR Fusion Complete"
