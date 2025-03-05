# Download open-cravat for annotation
# One-Time configuration to add the bioconda channel
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority strict

# Install Open-Cravat
conda install open-cravat
oc version

# Filter only biallelic SNPs
bcftools view -v snps -m2 -M2 -O v -o ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes_snps.vcf /mnt/project/data/vcf/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf
bcftools view -v snps -m2 -M2 -O v -o ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes_snps.vcf /mnt/project/data/vcf/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf

# Run annotation for build hg19
oc run ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes_snps.vcf -d . -l hg19
oc run ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes_snps.vcf -d . -l hg19

# takes too long

# Load needed annotation module
oc module install clinvar_acmg

# Try to annotate only with ClinVar ACMG annotation data
oc run ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes_snps.vcf -d . -l hg19 -a clinvar_acmg
oc run ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes_snps.vcf -d . -l hg19 -a clinvar_acmg

