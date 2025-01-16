#!/bin/bash
#SBATCH --job-name=STAR-Fusion-NF
#SBATCH --output=./slurmout/STAR-Fusion-NF-%j.out

# Module Loading
ml Nextflow/23.04.2

# Run the nextflow workflow
nextflow \ 
    run \ 
    main.nf \ 
    
