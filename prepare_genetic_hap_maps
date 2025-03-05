# use plink and eagle to make genetic maps for each hap file
plink2 --haps ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.haps --out ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps --make-bed
Eagle_v2.4.1/eagle --geneticMapFile /mnt/project/data/ARGs/genetic_map_hg19.txt --bfile ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps --outPrefix ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps --numThreads 60
