# Clustering of Haplotype Matrices

**Team Members:** 

- Jon Moller
- Ali Saadat V
- Daniel Chang
- William Lu
- Emrah Kacar
- Avish Jha
- Francesco Andreace

### Flowchart

<!-- ![CMU hackathon group 1 lucidchart](https://github.com/user-attachments/assets/de67dcf8-faa6-4e37-90f7-c5f1a2e6d4a0) -->

### Previous Work
https://github.com/collaborativebioinformatics/Haploblock_Clusters


[Nucleate Pittsburgh 2024](https://github.com/ShijieTang/BioHack_Haplotype)


### Abstract

### Introduction

### Related Works

### Methods

In this study, we developed a pipeline to analyze haplotype data from the 1000 Genomes Project and apply machine learning techniques for clustering and similarity analysis. The methodology is outlined as follows:

#### Step 1: Getting the Data

We utilized phased variant call format (VCF) files for chromosomes 6, 8, 21, and 22 from the 1000 Genomes Project. These VCF files were pre-phased using SHAPEIT2. We selected chr 6 as it was used by prior groups, chr 8 as it contains beta defensin and chr 21/22 due to their smaller sizes allowing for test processing.

#### Step 2: Converting the Data

The VCF files were converted into haplotype (HAP) format using Plink2. 

#### Step 3: Preprocessing the Data

The HAP files were preprocessed with the following steps:

- Space delimitation was enforced.
- The IDs in columns ID1 and ID2 were made identical.
- Unique IDs were assigned to variants with missing identifiers.
- The maximum allele length was set to 280 to standardize input data.


![image](flowchart.png)

### Results

### Discussion

### References
