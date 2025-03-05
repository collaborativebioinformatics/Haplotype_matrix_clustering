#!/bin/bash

# Define function for PLINK haplotype extraction and reformatting
function plink_hap_reformat() {
  # Extract haplotypes with PLINK, ensuring no missing variant IDs and SNP-only filtering
  plink2 --vcf ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz \
         --new-id-max-allele-len 280 --set-missing-var-ids @:#[b37]\$r,\$a \
         --snps-only 'just-acgt' --export haps --out ALL.${1}.haplotypes --max-alleles 2
  
  # Reformat sample file to ensure compatibility with ARG-Needle
  paste <(cut -f2 ALL.${1}.haplotypes.sample -d' ' | sed 's/ID_2/ID_1/g') <(cut -f2-4 ALL.${1}.haplotypes.sample -d ' ') > ALL.${1}.haplotypes.sample.reformatted
  
  # Clean up intermediate files
  rm ALL.${1}.haplotypes.sample.old
}

# Process chromosomes 6, 8, 21, and 22
for CHR in chr6 chr8 chr21 chr22; do
  plink_hap_reformat ${CHR}
done

echo "Preprocessing completed successfully."
