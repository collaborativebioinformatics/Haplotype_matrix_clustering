#!/bin/bash

# Define ranges for TNF-alpha, HLA-A, and beta-defensin
declare -A ranges=(
    ["TNF"]="6 31543342 31546113"
    ["HLAA"]="6 29910309 29913647"
    ["DEFB1"]="8 6728114 6735458"
)

# Loop through each gene and extract haplotypes
for gene in "${!ranges[@]}"; do
    # Create range file
    echo -e "${ranges[$gene]} 1" > ${gene}.range
    
    # Extract haplotypes using PLINK2
    plink2 --haps ALL.${ranges[$gene]%% *}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.haps \
           --extract range ${gene}.range \
           --export haps \
           --out ${gene}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps
    
    # Clean up intermediate files
    rm ${gene}.range
done

echo "Haplotype extraction for TNF-alpha, HLA-A, and beta-defensin completed successfully."
