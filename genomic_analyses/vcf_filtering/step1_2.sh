#!/bin/bash
#SBATCH --get-user-env
#SBATCH --clusters=biohpc_gen
#SBATCH --partition=biohpc_gen_normal
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4763mb
#SBATCH --time=2:00:00
#SBATCH -J Alps_1_2script.sh

#step 1: removing mismatched individuals
#vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/final_datasets/alps_wocgn_7added.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step1_2/Alps_1_nomismatchedind --remove /dss/dsshome1/0A/ra93rey/vcf/paper/step1_2/mismatched_ind --recode --recode-INFO-all

#step 2: removing loci with coverage > 500
vcftools --vcf ~/vcf/paper/step1_2/Alps_1_nomismatchedind.recode.vcf --exclude-positions ~/vcf/paper/step1_2/Alps_1_exclude_500.txt --out ~/vcf/paper/step1_2/Alps_2_nocoverage500 --recode --recode-INFO-all


##CHECK POINT##

# Depth indv/locus
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --depth
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --site-mean-depth
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --geno-depth

# Missing data indv/locus
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --missing-indv
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --missing-site

# Allele freq/indv freq buden
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --indv-freq-burden
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --freq2
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --singletons
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --012

# Heterozygosity per individual
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --het

# SNP call quality
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step1_2/Alps_2 --site-quality

