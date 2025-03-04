# keeping track of plink commands used to export haplotypes from SHAPEIT2 phased 1KG VCF input per chromosome
# run in DNAnexus ttyd, default parameters
# chromosome 21
plink2 --vcf /mnt/project/data/vcf/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz --export haps --out ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes --max-alleles 2
dx upload ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes* --path /data/hap
# chromosome 22
plink2 --vcf /mnt/project/data/vcf/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz --export haps --out ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes --max-alleles 2
dx upload ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes* --path /data/hap
# make chromosome variable/array to expedite next steps
