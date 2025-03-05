# use plink and eagle to make genetic maps for each hap file
plink2 --haps ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.haps --out ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps --make-bed
# Eagle_v2.4.1/eagle --geneticMapFile /mnt/project/data/ARGs/genetic_map_hg19.txt --bfile ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps --outPrefix ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps --numThreads 60
# didn't work, don't use Eagle
# do use this
conda create -n igp -c https://raw.githubusercontent.com/lightning-auriga/conda-builds/default/conda-builds -c bioconda -c conda-forge interpolate-genetic-position
conda activate igp
# make new map file with interpolated genetic positions
interpolate-genetic-position.out -i ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.bim -p bim -g /mnt/project/data/ARGs/genetic_map_hg19.txt -m bolt -o ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.interpolated.map -f map
# prep hap map function
prep_hap_maps () {
plink2 --haps ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.haps --out ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps --make-bed
interpolate-genetic-position.out -i ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.bim -p bim -g /mnt/project/data/ARGs/genetic_map_hg19.txt -m bolt -o ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.interpolated.map -f map
dx upload ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.interpolated.map --path /data/hap/ALL.${1}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.snps.map
}
# if necessary
conda activate igp
prep_hap_maps "chr6"
prep_hap_maps "chr8"
prep_hap_maps "chr22"
