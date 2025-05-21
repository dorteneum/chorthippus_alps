#!/bin/bash -l
#SBATCH --get-user-env
#SBATCH --job-name=vcf2plink
#SBATCH --output=vcf2plink_output_%j
#SBATCH --error=vcf2plink_error_%j

#last modified: 11.12.23

## 'emu' environment contains emupca, plink, and vcftools packages
conda activate emu

#go to the folder where I want the outputs to be saved. 
cd <current_working_directory>
#Create plink `.ped` format file for conversion using vcftools  
vcftools --vcf  /PATH/TO/VCF_FILE  --plink --out file_name
#Covert `.ped` file to `.bed` format 
plink --file file_name --make-bed --out final_file_name --allow-extra-chr --allow-no-sex
