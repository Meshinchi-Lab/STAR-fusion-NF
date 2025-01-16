#!/bin/bash

set -euo pipefail

# CHECKS
echo ""

# Load Module
ml MultiQC/1.21-foss-2023a

# Run the cluster command
echo "Running multiqc"

echo "Multiqc Complete"
