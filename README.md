# Clustering of Haplotype Matrices

> CMU Machine Learning and AI Approaches to Multimodal Problems in CompBio Hackathon 2025 - Group 1

**Team Members:** 

- Jon Moller
- Ali Saadat V
- Daniel Chang
- William Lu
- Emrah Kacar
- Avish Jha
- Francesco Andreace

### Introduction

Haplotype analysis plays a critical role in understanding genetic variation and evolutionary relationships. This study presents a computational pipeline on DNANexus that integrates haplotype data processing, ancestral recombination graph (ARG) reconstruction, and machine learning techniques to explore genetic similarity and clustering among samples. We used SHAPEIT2 phased variant call format (VCF) files from chromosomes 6, 8, 21, and 22 of the 1000 Genomes Project, converted the data into haplotype (HAP) format using Plink2, and applied preprocessing steps to standardize the input for ARG Needle. We also filtered chromosome 6 haplotypes for TNF and HLA-A variants and chromosome 8 for beta defensin, as TNF is one of the least variable genes in the human genome, while HLA-A and beta defensin are amongst the most variable. We obtained 61, 313, and 486 deduplicated biallelic SNPs for TNF, HLA-A, and beta defensin, respectively. We then performed hierarchical clustering and similarity matrix calculation from these gene-specific haplotypes.

<<TBD>>

### Related / Previous Works

[BCM HGSC / DNAnexus Hackathon 2024 - Haploblock Clusters](https://github.com/collaborativebioinformatics/Haploblock_Clusters)


[Nucleate Pittsburgh 2024 - BioHack Haplotype](https://github.com/ShijieTang/BioHack_Haplotype)

### Methods

In this study, we developed a pipeline to analyze [haplotype data from the 1000 Genomes Project](https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/) and apply machine learning techniques for clustering and similarity analysis. The methodology is outlined as follows:

![image](flowchart.png)

#### Step 1: Getting the Data

We utilized phased variant call format (VCF) files for chromosomes 6, 8, 21, and 22 from the 1000 Genomes Project. These VCF files were pre-phased using SHAPEIT2. We selected chr 6 as it was used by prior groups, chr 8 as it contains beta defensin, a highly variable gene involved in microbial immune response of interest to our group, and chr 21/22 due to their smaller sizes allowing for test processing.

#### Step 2: Converting the Data

The VCF files were converted into the Oxford phased haplotype file (HAP/.haps) format using PLINK2. 

#### Step 3: Preprocessing the Data

The HAP files were preprocessed with the following steps:

- Space delimitation was enforced as required by ARG-Needle.
- In the .sample files, the IDs in columns ID_1 and ID_2 were made identical via copying ID_2 to ID_1.
- In the .haps file, unique IDs were assigned to variants with missing identifiers.
- The maximum allele length was set to 280 to standardize input data.
- A new SNP name/ID was created by combining with columns 2-4 from the original sample file.
- Creating a new sample file with the modified format.

#### Step 4: Generating ARGs

To additionally prepare the data for generation of ARGs, both map and hap files needed to be modified so that positions to be arranged in monotonically increasing order by removing duplicated variants. In accordance with [Zhang et. al 2023](https://www.nature.com/articles/s41588-023-01379-x), we performed ARG inference in parallel by dividing phased data into equal, non-overlapping chunks, and performing ARG inference on each chunk.

#### Step 5: Clustering Analysis and Visualization

Clustering/unsupervised machine learning pipelines were initially established using the ARGN file generated from the example SNP data described in the ARG-Needle [manual](https://palamaralab.github.io/software/argneedle/manual/#quickstart).

A tree visualization method for the ARGs that extends the efforts of prior hackathon teams was similarly initially produced from the ARG-Needle example SNP data using tskit.

Running clustering analysis/hierarchical clustering on haps data...

To characterize the haplotypes based on clinical significance, we used the vcf files to isolate biallelic SNPs, then wrote code to use OpenCravat to annotate chromosomes with ClinVar ACMG annotation.

### Results

![image](1000g_pca.webp)

<<TBD>>

### Discussion

Although we were able to establish methods to perform clustering and annotation analysis of example ARG-needle data, a sticking point in our overall pipeline development was the difficulty of successfully producing ARGN files from the chromosome-level 1000 Genomes haplotype data.

One potential cause of the problems we’ve been experiencing with ARG-needle in this project could be because we’ve been trying to work with a highly diverse population from the 1000 Genomes project. ARG construction with ARG-needle relies on threading of samples into the graph based on similarity to other individuals, but ARG-needle was primarily tested on samples from the UK Biobank [(Zhang et. al 2023)](https://www.nature.com/articles/s41588-023-01379-x), representing a highly homogenous population. For our purposes, selecting a more homogenous subpopulation from the 1000 Genomes data on which to run ARG construction could work better.

Additional potential approaches to this issue could include using alternative tools like [GenoTools](https://github.com/dvitale199/GenoTools) or using brute-force generation similarity matrices from haplotype data.
<<TBD>>

### References

[1] Vitale, D., Koretsky, M. J., Kuznetsov, N., Hong, S., Martin, J., James, M., Makarious, M. B., Leonard, H., Iwaki, H., Faghri, F., Blauwendraat, C., Singleton, A. B., Song, Y., Levine, K., Kumar-Sreelatha, A. A., Fang, Z.-H., & Nalls, M. (2025). GenoTools: an open-source Python package for efficient genotype data quality control and analysis. G3 Genes|Genomes|Genetics, 15(1), jkae268. https://doi.org/10.1093/g3journal/jkae268

[2] Zhang, B., Biddanda, A., Gunnarsson, A. F., Cooper, F., & Palamara, P. F. (2023). Biobank-scale inference of ancestral recombination enables genealogical analysis of complex traits. *Nature Genetics*, 55, 768–776. https://doi.org/10.1038/s41588-023-01379-x.

#### Packages/Tools Used

- [PLINK2](https://www.cog-genomics.org/plink/2.0/)
- [ARG-Needle](https://palamaralab.github.io/software/argneedle/) and [source publication](https://www.nature.com/articles/s41588-023-01379-x)
- [tskit](https://tskit.dev/tskit/docs/stable/introduction.html)
- [interpolate-genetic-position](https://github.com/lightning-auriga/interpolate-genetic-position)
- [OpenCravat](https://docs.opencravat.org/en/latest/)
- [DNANexus](https://platform.dnanexus.com/)
- [JupyterLab](https://jupyter.org/)
