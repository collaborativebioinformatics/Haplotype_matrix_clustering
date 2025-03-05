FROM ubuntu:latest

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    build-essential \
    bcftools \
    tabix \
    plink2 \
    && apt-get clean

# Create a working directory
WORKDIR /app

# Download the relevant chromosome files from the 1000 Genomes Project FTP site
RUN wget -q ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz && \
    wget -q ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr8.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz && \
    wget -q ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz && \
    wget -q ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz

# Download corresponding idx files
RUN wget -q ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi && \
    wget -q ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr8.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi && \
    wget -q ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi && \
    wget -q ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi

# Copying the scripts into the container
COPY 001_preprocess.sh /app/001_preprocess.sh
COPY 002_filter_for_genes.sh /app/002_filter_for_genes.sh

# Making them executable
RUN chmod +x /app/001_preprocess.sh
RUN chmod +x /app/

# Running the scripts
CMD ["/bin/bash", "/app/001_preprocess.sh"]
CMD ["/bin/bash", "/app/002_filter_for_genes.sh"]

