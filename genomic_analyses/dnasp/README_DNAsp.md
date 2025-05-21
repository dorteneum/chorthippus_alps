# 6. Population summary statistics: Watterson's Theta and Tajima's D with DnaSP

To complement our genetic variability analysis, we also calculated Watterson's Theta using DnaSP software. Moreover, to test demographc stability, we estimated Tajima's D with the same program.

For the calculation of these population statistics, we used the **dataset B** (*Alps_fmdi-geno50imiss70.recode.vcf*).


## I) Files in this folder

- *README_DNAsp.md*: README file for the population summary statistics (Watterson's Theta and Tajima's D) with DnaSP.
- *DSB_paper.fa*: Dataset B in fasta format.
- *DSB_paper_unfold.fas*: Unfolded dataset B fasta file.
- *popasign_alps_paper.SG.txt*: Population assignment file.
- **outputs_paper_DNAsp** folder:
  - *Alps_fmdi-geno50imiss70.recode.VCF.out.RAD.\*.out*: DnaSP output files with different statistics for each of our taxa.
- *dnasp_plots_paper.R*: RStudio file for plotting Watterson's Theta and Tajima's D.
- **plots** folder:
  - *watttheta_vplot_paper_allAlps_k5.png*: Violin plot of the statistic Watterson's Theta per locus for each population.
  - *tajD_vplot_paper_allAlps_k5.png*: Violin plot of the statistic Tajima's D per locus for each population.


## II) DnaSP installation

We downloaded the zip file from http://www.ub.edu/dnasp/ to install the DnaSP program.


## III) Step by step guidelines

To estimate Watterson's Theta and Tajima's D using DnaSP, we followed these steps:
1. Converting the vcf file of dataset B to fasta format.
2. Unfolding the dataset file and creating the population file.
3. Executing DnaSP.
4. Plotting Watterson's Theta and Tajima's D statistics.

Note: DnaSP was run on a personal computer and not on an HPC cluster.

For help or further information about DnaSP, refer to the documentation at: http://www.ub.edu/dnasp/DnaSP6_Documentation_6.12.pdf 


### 1. Conversion of the dataset B vcf file to fasta format

We converted the .vcf file to a format that DnaSP understands, such as fasta format. To do this, we dowloaded PGDSpider, unzipped the folder and opened the application PGDSpider2. The corresponding format of the input data and the output file were selected. For the SPID conversion script, we chose "Create/Edit SPID file" and answered the questions accordingly. In our case, all the default options were used to obtain the file *DSB_paper.fa*.

More information can be found in config --> help, and the manual can be accessed here: http://popgen.unibe.ch/software/PGDSpider/PGDSpider%20manual_vers%202-1-1-5.pdf


### 2. Unfolding the dataset file and creating the population file.

In DnaSP, we opened the fasta file that was just created and ensured that the format was correct (in Data window) by clicking "display" and then "view data". As our data was folded, we unfolded it for diploid individuals with ambiguity codes (for heterozygous individuals) generating another fasta file *DSB_paper_unfold.fas*.

The population assignment file *popasign_alps_paper.SG.txt* (.SG.txt format is mandatory) was created following the intructions in the manual http://www.ub.edu/dnasp/DnaSP6_Documentation_6.12.pdf (e.g., page 20).


### 3. Running DnaSP

The unfold fasta file *DSB_paper_unfold.fas* was opened in DnaSP using "Multi-MSA Data File Analysis (All positions; RadSeq Data)..." and then clicking "Polymorphism and Divergence" (see page 20 of the manual). A new window appeared where we provided the required information (input file, population assignment file, folder and name of the output file), and ran the analysis.

Several outfiles were obatined. We used the files specific to each taxon:
- *Alps_fmdi-geno50imiss70.recode.VCF.out.RAD.biguttulus.out* 
- *Alps_fmdi-geno50imiss70.recode.VCF.out.RAD.brunneus.out*
- *Alps_fmdi-geno50imiss70.recode.VCF.out.RAD.m.ignifer.out*
- *Alps_fmdi-geno50imiss70.recode.VCF.out.RAD.m.mollis.out*
- *Alps_fmdi-geno50imiss70.recode.VCF.out.RAD.t.brunneus.out*


### 4. Plotting Watterson's Theta and Tajima's D

To create the plots, we followed the instructions in *dnasp_plots_paper.R* file in RStudio.
The final plots *watttheta_vplot_paper_allAlps_k5.png* and *tajD_vplot_paper_allAlps_k5.png* are located inside the "plots" folder.


## IV) References

Rozas, J., Ferrer-Mata, A., Sánchez-DelBarrio, J. C., Guirao-Rico, S., Librado, P., Ramos-Onsins, S. E., & 
Sánchez-Gracia, A. (2017). DnaSP 6: DNA Sequence Polymorphism Analysis of Large Data Sets. 
Molecular Biology and Evolution, 34(12), 3299–3302. https://doi.org/10.1093/molbev/msx248

