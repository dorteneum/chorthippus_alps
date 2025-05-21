#!/bin/bash
#SBATCH --get-user-env
#SBATCH --clusters=biohpc_gen
#SBATCH --partition=biohpc_gen_normal
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4763mb
#SBATCH --time=2:00:00
#SBATCH -J Alps_4script.sh
#SBATCH --output=Alps_4.out

#step 4: removing singletons

vcftools --vcf ~/vcf/paper/step3/Alps_fmdi-geno50imiss70.recode.vcf --out ~/vcf/paper/step4/Alps_wosing --mac 3 --recode --recode-INFO-all


##CHECK POINT##** - for Alps_wosing results of filtering singletons.

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --depth
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --site-mean-depth
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --geno-depth

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --missing-indv
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --missing-site

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --indv-freq-burden
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --freq2
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --singletons
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --012

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --het

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step4/Alps_wosing --site-quality

