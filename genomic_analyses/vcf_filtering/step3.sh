#!/bin/bash
#SBATCH --get-user-env
#SBATCH --clusters=biohpc_gen
#SBATCH --partition=biohpc_gen_normal
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4763mb
#SBATCH --time=2:00:00
#SBATCH -J Alps_3script.sh
#SBATCH --output=Alps_3_3.out



#step 3: removing missing data iteratively

##1st iteration : geno > 30%
#vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step3/Alps_3_geno30 --max-missing 0.3 --recode --recode-INFO-all

#vcftools --vcf ~/vcf/paper/step3/Alps_3_geno30.recode.vcf --out ~/vcf/paper/step3/Alps_3_it1 --missing-indv



# Remove flagged individuals

#vcftools --vcf ~/vcf/paper/step3/Alps_3_geno30.recode.vcf --out ~/vcf/paper/step3/Alps_fmdi-geno30imiss90 --remove ~/vcf/paper/step3/LQ_Ind_FMDI-90 --recode --recode-INFO-all

##CHECK POINT##** - for (1) geno > 30%, imiss < 90% results of filtering missing data.

#transform multi-allelic variants into bi-allelic variants (to use vcfallelicprimitives, need to install vcflib):
#vcfallelicprimitives ~/vcf/paper/step3/Alps_fmdi-geno30imiss90.recode.vcf --keep-info --keep-geno > ~/vcf/paper/step3/SNPs.vcf

#remove indels
#vcftools --vcf ~/vcf/paper/step3/SNPs.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --remove-indels --recode --recode-INFO-all


#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --depth
#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --site-mean-depth
#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --geno-depth

#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --missing-indv
#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --missing-site

#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --indv-freq-burden
#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --freq2
#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --singletons
#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --012

#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --het

#vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --site-quality



##2nd iteration: geno > 40%

#vcftools --vcf ~/vcf/paper/step3/Alps_fmdi-geno30imiss90.recode.vcf --out ~/vcf/paper/step3/Alps_3_geno40 --max-missing 0.4 --recode --recode-INFO-all

#vcftools --vcf ~/vcf/paper/step3/Alps_3_geno40.recode.vcf --out ~/vcf/paper/step3/Alps_3_it2 --missing-indv



# Remove flagged individuals

#vcftools --vcf ~/vcf/paper/step3/Alps_3_geno40.recode.vcf --out ~/vcf/paper/step3/Alps_fmdi-geno40imiss80 --remove ~/vcf/paper/step3/LQ_Ind_FMDI-80 --recode --recode-INFO-all


##CHECK POINT##** - for (2) geno > 40%, imiss < 80% results of filtering missing data.

#transform multi-allelic variants into bi-allelic variants (to use vcfallelicprimitives, need to install vcflib):
#vcfallelicprimitives ~/vcf/paper/step3/Alps_fmdi-geno40imiss80.recode.vcf --keep-info --keep-geno > ~/vcf/paper/step3/SNPs.vcf

#remove indels
#vcftools --vcf ~/vcf/paper/step3/SNPs.vcf --out ~/vcf/paper/step3/Alps_FMDI_2 --remove-indels --recode --recode-INFO-all


#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --depth
#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --site-mean-depth
#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --geno-depth

#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --missing-indv
#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --missing-site

#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --indv-freq-burden
#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --freq2
#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --singletons
#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --012

#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --het

#vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --site-quality


##3nd iteration: geno > 50%


vcftools --vcf ~/vcf/paper/step3/Alps_fmdi-geno40imiss80.recode.vcf --out ~/vcf/paper/step3/Alps_3_geno50 --max-missing 0.5 --recode --recode-INFO-all

vcftools --vcf ~/vcf/paper/step3/Alps_3_geno50.recode.vcf --out ~/vcf/paper/step3/Alps_3_it3 --missing-indv


# Remove flagged individuals

#vcftools --vcf ~/vcf/paper/step3/Alps_3_geno50.recode.vcf --out ~/vcf/paper/step3/Alps_fmdi-geno50imiss70 --remove ~/vcf/paper/step3/LQ_Ind_FMDI-70 --recode --recode-INFO-all


##DID NOT WORK## ##CHECK POINT##** - for (3) geno > 50%, imiss < 70% results of filtering missing data.

#transform multi-allelic variants into bi-allelic variants (to use vcfallelicprimitives, need to install vcflib):
vcfallelicprimitives ~/vcf/paper/step3/Alps_fmdi-geno50imiss70.recode.vcf --keep-info --keep-geno > ~/vcf/paper/step3/SNPs.vcf

#remove indels
vcftools --vcf ~/vcf/paper/step3/SNPs.vcf --out ~/vcf/paper/step3/Alps_FMDI_3 --remove-indels --recode --recode-INFO-all


vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --depth
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --site-mean-depth
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --geno-depth

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --missing-indv
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --missing-site

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --indv-freq-burden
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --freq2
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --singletons
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --012

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --het

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_3 --site-quality

