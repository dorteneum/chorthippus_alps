# 2. Data processing (filtering scheme)

After completing the assembly in ipyrad, we performed filtering on the raw dataset to remove low quality individuals and loci, enhancing the quality of our assembly. This was accomplished using vcftools and R software. Cleaned datasets were generated for further genetic analyses.


## I) Files in this folder

- *README_vcf_filtering_paper.md*: README file for the data processing (filtering scheme)
- *summary_plots.Rmd*: R script for producing plots and inspecting the data.
- *length_loci.R*: R script to determine the number of loci, the mean number of SNPs per locus and plot the loci length.
- **step0** folder: Checking raw dataset.
  - plots_step0 folder: Contains 8 plots (.png) describing the raw data.
- **step1_2** folder: Removing individuals and multilocus contigs.
  - *mismatched_ind*: List of IDs of individuals to remove
  - *step1_2.sh*: sbatch script with commands to run steps 1 and 2 of the filtering scheme.
  - *Alps_1_nomismatchedind.recode.vcf*: Dataset after removing individuals.
  - *Alps_1_nomismatchedind.ldepth.mean*: Mean depth per site of the dataset after removing individuals.
  - *multilocus_filter.Rmd*: R script to plot the average depth distribution and create a table with SNPs with a coverage higher than 500X.
  - *multilocus_500threshold_p8.png*: Plot of the mean read depth per locus vs the number of loci of the dataset after removing individuals.
  - *Alps_1_exclude_500.txt*: Table with the locus ID and the position in the locus of the SNPs with coverage above 500X.
  - *Alps_2_nocoverage500.recode.vcf*: **Dataset A**, obtained after removing multilocus contigs (SNPs> 500X coverage).
  - *Alps_2.\*\*\**: Output files to check the dataset A.
  - plots_step1_2 folder: Contains 8 plots (.png) describing dataset A.
- **step3** folder: Iterative filtering (FMDI).
  - *step3.sh*: sbatch script with commands to run step 3 of the filtering scheme.
  - *imiss_filter.Rmd*: R script to create a list of individuals with more than a certain percentage of missing data.
  - *SNPs.vcf*: List of SNPs to keep (changes with each iteration).
  - Files for the 1st iteration:
    - *Alps_3_geno30.recode.vcf*: Dataset after the geno > 30% filter.
    - *Alps_3_it1.imiss*: Missing data per individual after the geno > 30% filter.
    - *LQ_Ind_FMDI-90*: List of individuals with more than 90% of missing data.
    - *Alps_fmdi-geno30imiss90.recode.vcf*: Dataset after the first iteration of the FMDI filter.
    - *Alps_FMDI_1.\*\*\**: Output files to check the dataset after the first iteration of the FMDI filter.  
  - Files for the 2nd iteration:
    - *Alps_3_geno40.recode.vcf*: Dataset after the geno > 40% filter.
    - *Alps_3_it2.imiss*: Missing data per individual after the geno > 40% filter.
    - *LQ_Ind_FMDI-80*: List of individuals with more than 80% of missing data.
    - *Alps_fmdi-geno40imiss80.recode.vcf*: Dataset after the second iteration of the FMDI filter.
    - *Alps_FMDI_2.\*\*\**: Output files to check the dataset after the second iteration of the FMDI filter.
  - Files for the 3rd iteration:
    - *Alps_3_geno50.recode.vcf*: Dataset after the geno > 50% filter.
    - *Alps_3_it3.imiss*: Missing data per individual after the geno > 50% filter.
    - *LQ_Ind_FMDI-70*: List of individuals with more than 70% of missing data.
    - *Alps_fmdi-geno50imiss70.recode.vcf*: **Dataset B**, obtained after the third iteration of the FMDI filter.
    - *Alps_FMDI_3.\*\*\**: Output files to check the dataset after the third iteration of the FMDI filter.
  - plots_step3 folder: 
    - Alps_FMDI_1 folder: Contains 8 plots (.png) describing the dataset after the first iteration of FMDI.
    - Alps_FMDI_2 folder: Contains 8 plots (.png) describing the dataset after the second iteration of FMDI.
    - Alps_FMDI_3 folder: Contains 8 plots (.png) describing the data set B after the third iteration of FMDI.
  - FMDI_imiss_filter folder: Contains 3 plots (.png) of the missing data per individual vs the number of individuals for each iteration of FMDI.
- **step4** folder: Removing singletons.
  -  *step4.sh*: sbatch script with commands to run step 4 of the filtering scheme.
  -  *Alps_wosing.recode.vcf*: **Dataset C**, obtained after the FMDI filter and does not have singleton loci.
  -  *Alps_wosing.\*\*\**: Output files to check dataset C.
  - plots_step4 folder: Contains 8 plots (.png) describing dataset C.

## II) Step by step guidelines

The filtering scheme that we applied to the raw dataset consists of four main steps:
1. Individuals removal, if necessary.
2. Multilocus contigs removal.
3. Iterative missing data filtering (FMDI).

After each step, we assessed the quality and characteristics of the dataset (##CHECK POINT##).

For help or further information about vcftools software, refer to the documentation at: https://vcftools.github.io/examples.html

The GitHub repository is available at: 
https://github.com/vcftools/vcftools


### Step 0: Checking out the raw dataset - ##CHECK POINT##

Before filtering our raw data, we must inspect it. To achieve this, we extract the following key information from our dataset:
- mean depth coverage per individual, per site and for each genotype.
- missing data per individual and per site.
- variants present in each individual, allele frequency for each site and the location of singletons.
- heterozygosity levels and SNP call quality.


This information is retrieved through the execution of the following ##CHECK POINT## script.

```sbatch
# Depth indv/locus
".idepth" file with the mean depth per individual.
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --depth
".ldepth.mean" file with mean depth per site averaged across all individuals.
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --site-mean-depth
".gdepth" file with depth for each genotype in the VCF file.
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --geno-depth

# Missing data indv/locus
".imiss" file with missingness on a per-individual basis.
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --missing-indv
".lmiss" file with missingness on a per-site basis.
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --missing-site

# Allele freq/indv freq buden
".ifreqburden" file with number of variants within each individual of a specific frequency.
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --indv-freq-burden
".frq" file with allele frequency for each site but suppress output of any information about the alleles.
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --freq2
".singletons" file with location of singletons, and the individual they occur in.
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --singletons
".012", ".012.indv" and ".012.pos" files are the outputs of the genotypes as a large matrix.
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --012

# Heterozygosity per individual
".het" file. Calculates a measure of heterozygosity on a per-individual basis (the inbreeding coefficient, F).
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --het

# SNP call quality
".lqual" file with per-site SNP quality.
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/data/alps_wocgn_7added.vcf --out ~/paper_final_datasets/vcf_filtering/step0/Alps_raw --site-quality
```

After obtaining the 13 output files, we ran the R script *summary_plots.Rmd* to generate several histogram plots. Among these, the most informative at this stage are p1 (missing data per individual), p3 (mean read depth per individual), p7 (missing data per SNP) and p8 (mean read depth per SNP).
We also executed the R script *length_loci.R* R script to determine the number of loci, the mean number of SNPs per locus and plot the loci length.

Following the inspection of our raw data, we started with the filtering scheme.


### Step 1: Removing individuals (if necessary)

In a preliminary study, we found that six individuals were probably mislabeled either during fieldwork or in the laboratory. Therefore, it is advisable to exclude them.

First, we created the *mismatched_ind* file containing the IDs of the individuals, and then we remove them directly.

```
vcftools --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/final_datasets/alps_wocgn_7added.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step1_2/Alps_1_nomismatchedind --remove /dss/dsshome1/0A/ra93rey/vcf/paper/step1_2/mismatched_ind --recode --recode-INFO-all
```
The output dataset was *Alps_1_nomismatchedind.recode.vcf*.




### Step 2: Removing multilocus contigs

Loci with more than 500X coverage were deleted in order to remove from our dataset the possible paralogous loci.

Initially, we extracted the mean depth per site (.ldepth.mean) information:
```
vcftools --vcf ~/vcf/paper/step1_2/Alps_1_nomismatchedind.recode.vcf --site-mean-depth --out ~/vcf/paper/step1_2/Alps_1_nomismatchedind
```

To visualize and check the average depth distribution of our data in a plot, we executed the script *multilocus_filter.Rmd* in R. This script generated the plot *multilocus_500threshold_p8.png*, extracted SNPs above the cutoff value and exported a table *Alps_1_exclude_500.txt* containing these SNPs.

We proceeded to remove the sites with a mean depth higher than 500:

```
vcftools --vcf ~/vcf/paper/step1_2/Alps_1_nomismatchedind.recode.vcf --exclude-positions ~/vcf/paper/step1_2/Alps_1_exclude_500.txt --out ~/vcf/paper/step1_2/Alps_2_nocoverage500 --recode --recode-INFO-all
```

The output dataset *Alps_2_nocoverage500.recode.vcf* is designated as **dataset A**.

**##CHECK POINT##** - We inspected dataset A after removing multilocus contigs following the guidelines in "Step 0: Checking out the raw data - ##CHECK POINT##". 


### Step 3: filter missing data iteratively

To identify and remove loci and individuals with high amount of missing data (likely due to inadequate sequencing), we applied an iterative filter, herein called **FMDI** (Filtering Missing Data Iteratively), to our dataset A. This filter excluded sites based on the number of individuals called for a given locus (geno) and allowed a certain amount of missing data per individual (imiss). The thresholds and order of geno and imiss are iterative and we alternately made them stricter in each repetition. The three iterations were as follows:

(1) geno > 30%, imiss < 90%
(2) geno > 40%, imiss < 80%
(3) geno > 50%, imiss < 70%


**(1) geno > 30%**: we retained sites that have until 70% of missing data by removing all the other sites (30%).
```
vcftools --vcf ~/vcf/paper/step1_2/Alps_2_nocoverage500.recode.vcf --out ~/vcf/paper/step3/Alps_3_geno30 --max-missing 0.3 --recode --recode-INFO-all
```
Tha output file obtained was *Alps_3_geno30.recode.vcf*.

**(1) imiss < 90%**: we kept individuals that have until 90% of missing data and removed all others. 

We exported the information regarding missing data per individual.
```
vcftools --vcf ~/vcf/paper/step3/Alps_3_geno30.recode.vcf --out ~/vcf/paper/step3/Alps_3_it1 --missing-indv
```
We obtained the output file *Alps_3_it1.imiss*.

We executed the R script *imiss_filter.Rmd* for imiss < 90%. This created the plot *FMDI_it1_plot_mdperindiv.png* (located in the folder `plots_step3/FMDI_imiss_filter`) and produced the list *LQ_Ind_FMDI-90* of flagged individuals with missing data exceeding 90%.

These flagged individuals were then removed:
```
vcftools --vcf ~/vcf/paper/step3/Alps_3_geno30.recode.vcf --out ~/vcf/paper/step3/Alps_fmdi-geno30imiss90 --remove ~/vcf/paper/step3/LQ_Ind_FMDI-90 --recode --recode-INFO-all
```
The resulting dataset was *Alps_fmdi-geno30imiss90.recode.vcf*.


**##CHECK POINT##** - We inspected the data after the first iteration (geno > 30%, imiss < 90%) of the FMDI filter. To do so, we followed these steps:
```
#transform multi-allelic variants into bi-allelic variants (to use vcfallelicprimitives, you need to install vcflib):
vcfallelicprimitives ~/vcf/paper/step3/Alps_fmdi-geno30imiss90.recode.vcf --keep-info --keep-geno > ~/vcf/paper/step3/SNPs.vcf

#remove indels
vcftools --vcf ~/vcf/paper/step3/SNPs.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --remove-indels --recode --recode-INFO-all

vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --depth
vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --site-mean-depth
vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --geno-depth

vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --missing-indv
vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --missing-site

vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --indv-freq-burden
vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --freq2
vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --singletons
vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --012

vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --het

vcftools --vcf ~/vcf/paper/step3/Alps_FMDI_1.recode.vcf --out ~/vcf/paper/step3/Alps_FMDI_1 --site-quality
```
Once the output files are obtained, we ran the R script *summary_plots.Rmd* to produce several histogram plots. At the moment, the most informative at this stage are p1 (missing data per individual), p3 (mean read depth per individual), p7 (missing data per SNP) and p8 (mean read depth per SNP).
We also executed the R script *length_loci.R* R script to determine the number of loci, the mean number of SNPs per locus and plot the loci length.



**(2) geno > 40%**: we retained sites that have until 60% of missing data by removing all the other sites (40%).
```
vcftools --vcf ~/vcf/paper/step3/Alps_fmdi-geno30imiss90.recode.vcf --out ~/vcf/paper/step3/Alps_3_geno40 --max-missing 0.4 --recode --recode-INFO-all
```
We obtained the output file *Alps_3_geno40.recode.vcf*.

**(2) imiss < 80%**: we kept individuals that have until 80% of missing data and removed all others. 

We exported the information regarding missing data per individual.
```
vcftools --vcf ~/vcf/paper/step3/Alps_3_geno40.recode.vcf --out ~/vcf/paper/step3/Alps_3_it2 --missing-indv
```
The output file obtained was *Alps_3_it2.imiss*.

We executed the R script *imiss_filter.Rmd* for imiss < 80%. This created the plot *FMDI_it2_plot_mdperindiv.png* (located in the folder `plots_step3/FMDI_imiss_filter`) and produced the list *LQ_Ind_FMDI-80* of flagged individuals with missing data exceeding 80%.

These flagged individuals were then removed:
```
vcftools --vcf ~/vcf/paper/step3/Alps_3_geno40.recode.vcf --out ~/vcf/paper/step3/Alps_fmdi-geno40imiss80 --remove ~/vcf/paper/step3/LQ_Ind_FMDI-80 --recode --recode-INFO-all
```
The resulting dataset was *Alps_fmdi-geno40imiss80.recode.vcf*.


**##CHECK POINT##** - We inspected the data after the second iteration (geno > 40%, imiss < 80%) of the FMDI filter. To do so, we followed these steps:
```
#transform multi-allelic variants into bi-allelic variants (to use vcfallelicprimitives, you need to install vcflib):
vcfallelicprimitives ~/vcf/paper/step3/Alps_fmdi-geno40imiss80.recode.vcf --keep-info --keep-geno > ~/vcf/paper/step3/SNPs.vcf

#remove indels
vcftools --vcf ~/vcf/paper/step3/SNPs.vcf --out ~/vcf/paper/step3/Alps_FMDI_2 --remove-indels --recode --recode-INFO-all

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --depth
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --site-mean-depth
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --geno-depth

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --missing-indv
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --missing-site

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --indv-freq-burden
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --freq2
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --singletons
vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --012

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --het

vcftools --vcf /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2.recode.vcf --out /dss/dsshome1/0A/ra93rey/vcf/paper/step3/Alps_FMDI_2 --site-quality
```
Once the output files are obtained, we ran the R script *summary_plots.Rmd* to produce several histogram plots. At the moment, the most informative at this stage are p1 (missing data per individual), p3 (mean read depth per individual), p7 (missing data per SNP) and p8 (mean read depth per SNP).
We also executed the R script *length_loci.R* R script to determine the number of loci, the mean number of SNPs per locus and plot the loci length.


**(3) geno > 50%**: we retained sites that have until 50% of missing data by removing all the other sites (50%).
```
vcftools --vcf ~/vcf/paper/step3/Alps_fmdi-geno40imiss80.recode.vcf --out ~/vcf/paper/step3/Alps_3_geno50 --max-missing 0.5 --recode --recode-INFO-all
```
We obtained the output file *Alps_3_geno50.recode.vcf*.

**(3) imiss < 70%**: we kept individuals that have until 70% of missing data and removed all others. 

We explorted the information regarding missing data per individual.
```
vcftools --vcf ~/vcf/paper/step3/Alps_3_geno50.recode.vcf --out ~/vcf/paper/step3/Alps_3_it3 --missing-indv
```
The output file obtained was *Alps_3_it3.imiss*.

We executed the R script *imiss_filter.Rmd* for imiss < 70%. This created the plot *FMDI_it3_plot_mdperindiv.png* (located in the folder `plots_step3/FMDI_imiss_filter`) and produced the list *LQ_Ind_FMDI-70* of flagged individuals with missing data exceeding 70%.

These flagged individuals were then removed:
```
vcftools --vcf ~/vcf/paper/step3/Alps_3_geno50.recode.vcf --out ~/vcf/paper/step3/Alps_fmdi-geno50imiss70 --remove ~/vcf/paper/step3/LQ_Ind_FMDI-70 --recode --recode-INFO-all
```
The resulting dataset was *Alps_fmdi-geno50imiss70.recode.vcf* herein called **dataset B**.


**##CHECK POINT##** - We inspected dataset B after the third iteration (geno > 50%, imiss < 70%) of the FMDI filter. To do so, we followed these steps:
```
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
```
Once the output files are obtained, we ran the R script *summary_plots.Rmd* to produce several histogram plots. At the moment, the most informative at this stage are p1 (missing data per individual), p3 (mean read depth per individual), p7 (missing data per SNP) and p8 (mean read depth per SNP).
We also executed the R script *length_loci.R* R script to determine the number of loci, the mean number of SNPs per locus and plot the loci length.


## III) Datasets

The datasets obtained after the filtering the data are:
- **Dataset A**
  - File name: *Alps_2_nocoverage500.recode.vcf*
  - Folder: paper_final_datasets
  - Path: paper_final_datasets/Alps_2_nocoverage500.recode.vcf
  - Analyses using this data set: 
    - A PCA using the software EMU to examine the population structure of our taxa.
- **Dataset B**
  - File name: *Alps_fmdi-geno50imiss70.recode.vcf*
  - Folder: paper_final_datasets
  - Path: paper_final_datasets/Alps_fmdi-geno50imiss70.recode.vcf
  - Analyses using this data set: 
    - A coancestry matrix runned with fineRADstructure software to investigate the level of admixture between individuals.
    - To estimate population summary statistics, we use the software Pixy (for Pi and FST) and DnaSP (for Tajima's D and Watterson theta)
    - A coalescent phylogenetic tree built using tetrad within the ipyrad toolkit.


## IV) References

Danecek, P., Auton, A., Abecasis, G., Albers, C. A., Banks, E., DePristo, M. A., Handsaker, R. E., Lunter, 
G., Marth, G. T., Sherry, S. T., McVean, G., Durbin, R., & 1000 Genomes Project Analysis Group. (2011). 
The variant call format and VCFtools. Bioinformatics, 27(15), 2156–2158. 
https://doi.org/10.1093/bioinformatics/btr330

O’Leary, S. J., Puritz, J. B., Willis, S. C., Hollenbeck, C. M., & Portnoy, D. S. (2018). These aren’t the loci 
you’e looking for: Principles of effective SNP filtering for molecular ecologists. Molecular Ecology, 
27(16), 3193–3206. https://doi.org/10.1111/mec.14792

