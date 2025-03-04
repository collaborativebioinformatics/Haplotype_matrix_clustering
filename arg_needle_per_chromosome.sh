#run within dxjupyterlab console
# chromosome 6
arg_needle --hap_gz /mnt/project/data/hap/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.haps \
--map /mnt/project/data/ARGs/genetic_map_hg19.txt \
--out /mnt/project/data/ARGs/chr6 \
--mode sequence \
--chromosome 6
# chromosome 21
arg_needle --hap_gz /mnt/project/data/hap/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.haps \
--map /mnt/project/data/ARGs/genetic_map_hg19.txt \
--out /mnt/project/data/ARGs/chr21 \
--mode sequence \
--chromosome 21

