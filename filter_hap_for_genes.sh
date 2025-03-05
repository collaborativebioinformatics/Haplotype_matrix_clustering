# recreate steps to get TNF-alpha, HLA, and beta-defensin from chr6 and chr8 dedupped SNP haps
# TNF - chr 6 31543342..31546113 on hg37 per https://www.ncbi.nlm.nih.gov/gene/7124
# HLAA - chr 6 29910309..29913647 on hg37 per https://www.ncbi.nlm.nih.gov/gene/3105
# DEFB1 defensin beta 1 - chr 8 6728114..6735458 on hg37 per https://www.ncbi.nlm.nih.gov/gene/1672
plink2 ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.*
dx upload TNF.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.hap --path /data/haps/genes/TNF.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.hap
dx upload HLAA.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.hap --path /data/haps/genes/HLAA.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.hap
dx upload DEFB1.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.hap --path /data/haps/genes/DEFB1.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.hap
