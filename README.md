# Clustering of Haplotype Matrices

**Team Members:** 

- Jon Moller
- Ali Saadat V
- Daniel Chang
- William Lu
- Emrah Kacar
- Avish Jha
- Francesco Andreace

### Abstract

Haplotype analysis plays a critical role in understanding genetic variation and evolutionary relationships. This study presents a computational pipeline on DNANexus that integrates haplotype data processing, ARG reconstruction, and machine learning techniques to explore genetic similarity and clustering among samples. We used SHAPEIT2 phased variant call format (VCF) files from chromosomes 6, 8, 21, and 22 of the 1000 Genomes Project, we converted the data into haplotype (HAP) format using Plink2 and applied preprocessing steps to standardize the input for ARG Needle.

<<TBD>>

### Introduction

<<TBD>>

### Related / Previous Works

[BCM HGSC / DNAnexus Hackathon 2024 - Haploblock Clusters](https://github.com/collaborativebioinformatics/Haploblock_Clusters)


[Nucleate Pittsburgh 2024 - BioHack Haplotype](https://github.com/ShijieTang/BioHack_Haplotype)

### Methods

In this study, we developed a pipeline to analyze [haplotype data from the 1000 Genomes Project](https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/) and apply machine learning techniques for clustering and similarity analysis. The methodology is outlined as follows:

#### Step 1: Getting the Data

We utilized phased variant call format (VCF) files for chromosomes 6, 8, 21, and 22 from the 1000 Genomes Project. These VCF files were pre-phased using SHAPEIT2. We selected chr 6 as it was used by prior groups, chr 8 as it contains beta defensin and chr 21/22 due to their smaller sizes allowing for test processing.

#### Step 2: Converting the Data

The VCF files were converted into haplotype (HAP) format using Plink2. 

#### Step 3: Preprocessing the Data

The HAP files were preprocessed with the following steps:

- Space delimitation was enforced as required by ARG-Needle.
- The IDs in columns ID1 and ID2 were made identical via copying ID2 to ID1.
- Unique IDs were assigned to variants with missing identifiers.
- The maximum allele length was set to 280 to standardize input data.
- Combining it with columns 2-4 from the original sample file.
- Creating a new sample file with the modified format.

#### Step 4: Generating ARGs

![image](flowchart.png)

### Results

<<TBD>>

### Discussion

<<TBD>>

### References
