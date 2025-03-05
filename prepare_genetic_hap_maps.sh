# use plink and eagle to make genetic maps for each hap file
plink2 --haps ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.haps --out ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps --make-bed
# Eagle_v2.4.1/eagle --geneticMapFile /mnt/project/data/ARGs/genetic_map_hg19.txt --bfile ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps --outPrefix ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps --numThreads 60
# didn't work, don't use Eagle
# do use this

/home/dnanexus/miniforge3/bin/mamba create -n igp -c https://raw.githubusercontent.com/lightning-auriga/conda-builds/default/conda-builds -c bioconda -c conda-forge interpolate-genetic-position
conda activate igp
# make new map file with interpolated genetic positions
interpolate-genetic-position.out -i ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.bim -p bim -g /mnt/project/data/ARGs/genetic_map_hg19.txt -m bolt -o ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.interpolated.map -f map
# prep hap map function
prep_hap_maps () {
# keep only first of duplicated positions so that map is monotonically increasing
plink2 --haps /mnt/project/data/hap/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.haps --rm-dup force-first --out ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps --make-bed
interpolate-genetic-position.out -i ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.bim -p bim -g /mnt/project/data/ARGs/genetic_map_hg19.txt -m bolt -o ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.interpolated.map -f map
# remove duplicate positions with plink 1.9
# plink --map ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.interpolated.map --list-duplicate-vars suppress-first
# get unique positions
uniq -f3 ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.interpolated.map > ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.interpolated.unique.map 
dx upload ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.interpolated.unique.map --path /data/hap/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.dedup_snps.map
}
# if necessary
conda activate igp
prep_hap_maps "chr6"
prep_hap_maps "chr8"
prep_hap_maps "chr21"
prep_hap_maps "chr22"
