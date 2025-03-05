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
# prepare sample files in a form amenable to ARG-needle (ID_1 and ID_2 match)
# must be space delimited
function reformat_hap_sample () {
paste <(cut -f2 /mnt/project/data/hap/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.sample -d' '| sed 's/ID_2/ID_1/g') <(cut -f2-4 /mnt/project/data/hap/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.sample -d ' ') -d ' ' > ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.sample
}
# run on all four chromosomes
reformat_hap_sample "chr6"
reformat_hap_sample "chr8"
reformat_hap_sample "chr21"
reformat_hap_sample "chr22"
# redo everything with unique variant IDs after troubles with arg_needle
function plink_hap_reformat_dx_upload () {
# note some files are VCF and some are gzipped VCF (either one or other, not both)
# plink hap extraction with variant relabeling (no missing variant IDs)
plink2 --vcf $(ls /mnt/project/data/vcf/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf* | head -n 1) --new-id-max-allele-len 280 --set-missing-var-ids @:#[b37]\$r,\$a --export haps --out ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes --max-alleles 2
# samples file reformatting
paste <(cut -f2 /mnt/project/data/hap/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.sample -d' '| sed 's/ID_2/ID_1/g') <(cut -f2-4 /mnt/project/data/hap/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.sample -d ' ') -d ' ' > ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.sample
# push back to /data/hap
dx upload ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes* --path /data/hap
# clean up leftover garbage
rm -rf ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes*
}
# run on each chromosome
plink_hap_reformat_dx_upload "chr6"
plink_hap_reformat_dx_upload "chr8"
plink_hap_reformat_dx_upload "chr21"
plink_hap_reformat_dx_upload "chr22"
# redo with SNPs only!!
function plink_hap_snp_reformat_dx_upload () {
# note some files are VCF and some are gzipped VCF (either one or other, not both)
# plink hap extraction with variant relabeling (no missing variant IDs)
plink2 --vcf $(ls /mnt/project/data/vcf/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf* | head -n 1) --snps-only 'just-acgt' --new-id-max-allele-len 280 --set-missing-var-ids @:#[b37]\$r,\$a --export haps --out ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps --max-alleles 2
# samples file reformatting
mv ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.sample ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.sample.old
paste <(cut -f2 ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.sample.old -d' '| sed 's/ID_2/ID_1/g') <(cut -f2-4 ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.sample.old -d ' ') -d ' ' > ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.sample
# push back to /data/hap
dx upload ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.* --path /data/hap
# clean up leftover garbage
rm -rf ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes*
}
# run on each chromosome
plink_hap_snp_reformat_dx_upload "chr6"
plink_hap_snp_reformat_dx_upload "chr8"
plink_hap_snp_reformat_dx_upload "chr21"
plink_hap_snp_reformat_dx_upload "chr22"
# need this deduplicated
function plink_hap_snp_reformat_dx_upload () {
# note some files are VCF and some are gzipped VCF (either one or other, not both)
# plink hap extraction with variant relabeling (no missing variant IDs)
plink2 --vcf $(ls /mnt/project/data/vcf/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf* | head -n 1) --rm-dup force-first --snps-only 'just-acgt' --new-id-max-allele-len 280 --set-missing-var-ids @:#[b37]\$r --export haps --out ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps --max-alleles 2
# samples file reformatting
mv ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.sample ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.sample.old
paste <(cut -f2 ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.sample.old -d' '| sed 's/ID_2/ID_1/g') <(cut -f2-4 ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.sample.old -d ' ') -d ' ' > ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.sample
# push back to /data/hap
dx upload ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.* --path /data/hap
# clean up leftover garbage
rm -rf ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes*
}
