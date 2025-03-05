# recreate steps to get TNF-alpha, HLA, and beta-defensin from chr6 and chr8 dedupped SNP haps
# TNF - chr 6 31543342..31546113 on hg37 per https://www.ncbi.nlm.nih.gov/gene/7124
# HLAA - chr 6 29910309..29913647 on hg37 per https://www.ncbi.nlm.nih.gov/gene/3105
# DEFB1 defensin beta 1 - chr 8 6728114..6735458 on hg37 per https://www.ncbi.nlm.nih.gov/gene/1672
echo -e "6 31543342 31546113 1" > TNF.range
echo -e "6 29910309 29913647 1" > HLAA.range
echo -e "8 6728114 6735458 1" > DEFB1.range
plink2 --haps /mnt/project/data/hap/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.haps --extract range TNF.range --export haps --out TNF.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps
plink2 --haps /mnt/project/data/hap/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.haps --extract range HLAA.range --export haps --out HLAA.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps
plink2 --haps /mnt/project/data/hap/ALL.chr8.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.haps --extract range DEFB1.range --export haps --out DEFB1.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps
dx upload TNF.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps* --path /data/hap/genes/
dx upload HLAA.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps* --path /data/hap/genes/
dx upload DEFB1.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps* --path /data/hap/genes/
