# keeping track of plink commands used to export haplotypes from SHAPEIT2 phased 1KG VCF input per chromosome
# exclude multiallelic positions (--max-alleles 2)
# run in DNAnexus ttyd, default parameters
# chromosome 21
plink2 --vcf /mnt/project/data/vcf/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz --export haps --out ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes --max-alleles 2
dx upload ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes* --path /data/hap
# chromosome 22
plink2 --vcf /mnt/project/data/vcf/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz --export haps --out ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes --max-alleles 2
dx upload ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes* --path /data/hap
# possibly make chromosome variable/array to expedite next steps
# main subroutine to reproduce steps above (export haplotypes from VCF, upload to /data/hap via dx)
function plink_hap_dx_upload () {
# note some files are VCF and some are gzipped VCF (either one or other, not both)
plink2 --vcf /mnt/project/data/vcf/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf* --export haps --out ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes --max-alleles 2
dx upload ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes* --path /data/hap
# clean up leftover garbage
rm -rf ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes*
}
plink_hap_dx_upload "chr6"
plink_hap_dx_upload "chr8"
