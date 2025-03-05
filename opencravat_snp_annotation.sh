# Download open-cravat for annotation
# conda install open-cravat or pip install open-cravat

# Filter only biallelic SNPs
bcftools view -v snps -m2 -M2 -O v -o ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes_snps.vcf /mnt/project/data/vcf/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf

# Run annotation for build hg19
oc run ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes_snps.vcf -d . -l hg19
