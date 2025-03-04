#run within dxjupyterlab console
# run example for Emrah
# first microarray
arg_needle_prepare_example
arg_needle --hap_gz example.hap.gz \
--map example.map \
--out example \
--mode array
arg_needle 
arg_needle --asmc_clust 1
# then sequence
arg_needle_prepare_example --mode sequence --length 5e5
arg_needle --out example_seq
arg_needle --asmc_clust 1 --out example_seq_clust
# chromosome 6
arg_needle --hap_gz /mnt/project/data/hap/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.haps \
--map /mnt/project/data/ARGs/genetic_map_hg19.txt \
--out chr6 \
--mode sequence \
--chromosome 6
# chromosome 21
arg_needle --hap_gz /mnt/project/data/hap/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.haps \
--map /mnt/project/data/ARGs/genetic_map_hg19.txt \
--out chr21 \
--mode sequence \
--chromosome 21

