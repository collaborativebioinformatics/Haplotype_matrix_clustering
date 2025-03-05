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
--map ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.interpolated.map \
--out chr6 \
--mode sequence \
--chromosome 6
# chromosome 21
arg_needle --hap_gz /mnt/project/data/hap/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.haps \
--map ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.interpolated.map \
--out chr21 \
--mode sequence \
--chromosome 21
# make correct map file with bash/Unix coreutils one liner
paste <(cut -f1,2 -d' ' ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.haps) <(yes "0" | head -n1054447) <(cut -f3 -d' ' ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.haps)
# see prepare_genetic_hap_maps.sh for map file correction
run_arg_needle_wrapper () {
arg_needle --hap_gz /mnt/project/data/hap/ALL.chr${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.haps \
--map /mnt/project/data/hap/ALL.chr${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.map \
--out chr${1} \
--mode sequence \
--chromosome ${1}
}
