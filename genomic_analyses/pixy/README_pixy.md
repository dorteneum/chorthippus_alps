# 5. Population summary statistics: Pi and Fst with Pixy

We assessed genetic variability by calculating nucleotide diversity (pi) using Pixy software. With the same program, we estimated Fst to quantify genetic differentiation between each pair of taxa. 

For this analysis we used the **dataset B** (*Alps_fmdi-geno50imiss70.recode.vcf*).

Pixy was a suitable choice for our dataset because it accounts for missing data when calculating population statistics by not assuming it as invariant sites (Korunes & Samuk, 2021). Pixy is specifically designed to avoid bias or underestimation of Pi by excluding missing data from the calculation. 


## I) Files in this folder

- *README_pixy.md*: README file for the population summary statistics (Pi and Fst) with Pixy.
- *loci_length_hist_DSA_paper\*.png*: Histograms depicting the length distribution of loci in dataset A.
- *loci_length_hist_DSB_paper\*.png*: Histograms showing the length distribution of loci in dataset B.
- *pop_190indiv_K5.txt*: Population file containing samples IDs with their corresponding populations. 
- *pixy_paper_ws300_\**: Information about the Pixy run.
- **outputs_paper_ws300** folder: Contains pi, Fst and Dxy .txt output files from Pixy.
  - *datasetB_paper_Alps_out_dxy.txt*: Average Dxy per locus for each pair of taxa.
  - *datasetB_paper_Alps_out_fst.txt*: Average Fst per locus for each pair of taxa. 
  - *datasetB_paper_Alps_out_pi.txt*: Average pi per locus for each taxa.
- *Plots_script.R*: RStudio script for plotting pi and Fst.
- **plots_paper_ws300** folder:
  - *fst_\*plot_paper_allAlps_k5.png*: Box and violin plots showing the average fst per window for each pair of populations.
  - *pi_\*plot_paper_allAlps_k5.png*: Box, density and violin plots depicting the average pi per window for each population.


## II) Pixy installation

We installed Pixy with these commands:
```
conda install -c conda-forge pixy
conda install -c bioconda/label/broken htslib
```

## III) Step by step guidelines

To estimate pi and Fst with Pixy, we followed the next five steps:
1. Determining the optimal window size for the analysis.
2. Creating the population file.
3. Compressing and indexing the vcf file (dataset B).
4. Running Pixy.
5. Plotting pi and Fst.

For help and further information about Pixy, refer to the documentation at: https://pixy.readthedocs.io/en/latest/index.html 

The GitHub repository is available at: https://github.com/ksamuk/pixy 


### 1. Determining the width of --window_size

As not all the loci of our dataset B were the same length but had similar lengths, we decided to set the maximum length of the loci as the window size. This way, Pixy calculated the average values of Pi per locus per taxa, and the average Fst per locus per each pair of taxa. However, in this case, the calculation of pi and Fst population statistics was underestimated because several loci were shorter than the maximum length.

To determine the average and maximum length in base pairs (bp) of the loci, the *length_loci.R* script from the vcf_filtering folder was executed. 

We obtained that the dataset B had a **maximum loci length of 300**, which was set as the size of our window, and an average of 281.0452.

The *length_loci.R* script also created a histogram *loci_length_hist_DS\*_paper.png* illustrating the length distribution of the loci for better visualization (for both datasets) and calculated the mean number of SNPs per locus.


### 2. Creation of the population file

The population file was necessary for the program to assign individuals to their corresponding populations.
This file (*pop_190indiv_K5.txt*) needed to be in .txt format with the first column being the id/code of the samples and the second column being the population/taxa from which the sample belonged.

Note: Ensure that all the samples in your populations file are separated by a tab instead of 2 spaces.


### 3. Compressing and indexing the vcf file (dataset B)

```
bgzip /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/paper_final_datasets/Alps_fmdi-geno50imiss70.recode.vcf

tabix /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/paper_final_datasets/Alps_fmdi-geno50imiss70.recode.vcf.gz
```

The compressed outfile *Alps_fmdi-geno50imiss70.recode.vcf.gz* and the indexed outfile *Alps_fmdi-geno50imiss70.recode.vcf.gz.tbi* are located outside the pixy folder (
`/dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/paper_final_datasets`).


### 4. Running Pixy

We considered the following options when running Pixy:
 
**--stats**: pi, Fst and/or Dxy
**--vcf**: path to the input compressed vcf file (.vcf.gz format)
**--populations**: population file
**--window_size**: set to the maximum loci length. Alternatively, there is the option of using the path to a .BED file (--bed_file)
**--n_cores**: number of CPUs to utilize for parallel processing (default=1)
**--output_folder**: path to the folder where we wish to store the output files
**--output_prefix**: name of the output file(s)
**--bypass_invariant_check**: use if the file only has invariant sites (like the one we have)

We executed Pixy in sbatch to calculate pi, Fst and Dxy:
```
pixy --stats pi fst dxy --vcf /dss/dsslegfs01/pr53da/pr53da-dss-0029/diana/paper_final_datasets/Alps_fmdi-geno50imiss70.recode.vcf.gz --populations /dss/dsshome1/0A/ra93rey/pixy/pop_190indiv_K5.txt --window_size 300 --n_cores 4 --output_folder /dss/dsshome1/0A/ra93rey/pixy/outputs_paper_ws300 --output_prefix datasetB_paper_Alps_out --bypass_invariant_check yes
```
The output files *datasetB_paper_Alps_out_dxy.txt*, *datasetB_paper_Alps_out_fst.txt* and *datasetB_paper_Alps_out_pi.txt* are located in the outputs_paper_ws300 folder.


### 5. Plotting pi and fst

We executed and followed the instructions of the *Plots_script.R* script. The pi and fst plots can be found in the plots_paper_ws300 folder.


## IV) References

Korunes, K. L., & Samuk, K. (2021). PIXY: Unbiased estimation of nucleotide diversity and divergence in the presence of missing data. Molecular Ecology Resources, 21(4), 1359–1368. https://doi.org/10.1111/1755-0998.13326