# 4. Population structure analysis: admixture between species

In addition to EMU PCA, we employed the fineRADstructure software to further investigate the population structure of our taxa and assess the level of admixture between species.

For this analysis, we used the **dataset B** (*Alps_fmdi-geno50imiss70.recode.vcf*).


## I) Files in this folder

- *README_fineradstruct.md*: README file for the population structure analysis (admixture between species) with fineRADstructure.
- **scripts** folder: Containing scripts and output files of the four steps executed with fineradstructure.
  - *finerad_allsteps.sh*: Sbatch script for all the steps run with the fineradstructure program.
  - *finerad_convert_inputfile.sh*: Sbatch script to convert the dataset B .vcf file to .finerad format (1st step).
  - *Alps_dsB_paper.finerad*: Dataset B in .finerad format (output file of the 1st step).
  - *finerad_coamatrix.sh*: Sbatch script that calculates the co-ancestry matrix (2nd step).
  - *Alps_dsB_paper_missingness.out*: Output file showing missing data per individual after running the 2nd step.
  - *Alps_dsB_paper_missingnessMatrix.out*: Output file displaying the matrix of missingness per individual after running the 2nd step.
  - *Alps_dsB_paper_chunks.out*: Final coancestry matrix, output file after running the 2nd step and input file for the 3rd step.
  - *finerad_popasg.sh*: Sbatch script for assigning individuals to populations (3rd step).
  - *Alps_dsB_paper_chunks.mcmc.xml*: Output file after running the 3rd step.
  - *finerad_treebuild.sh*: Sbatch script for building the phylogenetic tree (4th step).
  - *Alps_dsB_paper_chunks.mcmcTree.xml*: Output file after running the 4th step.
  - *fineRADstructurePlot.R*: RStudio script for creating the three plots of the population structure.
  - *FinestructureLibrary.R*: RStudio file containing libraries needed when running *fineRADstructurePlot.R*.
- *Alps_dsB_paper_frs-SimpleCoancestry.pdf*: Plot representing the simple coancestry matrix.
- *Alps_dsB_paper_frs-PopAveragedCoancestry.pdf*: Plot depicting the populations and coancestry averages.
- *Alps_dsB_paper_frs-PopAveragedCoancestry2.pdf*: Plot illustrating the populations and coancestry averages with potentially more informatives labels.
- *Figure_fineRADstruct_paper.pdf*: Final version of the plot depicting the populations and coancestry averages in pdf format.
- *Figure_fineRADstruct_paper.svg*: Final version of the plot depicting the populations and coancestry averages in svg format.


## II) FineRADstructure installation

First of all, it's essential to be aware of the required libraries and their versions to install fineRADstructure in conda (https://bioconda.github.io/recipes/fineradstructure/README.html):
- gsl >=2.7 and <2.8.0a0
- libgcc-ng >=12
- libstdcxx-ng >=12
- libzlib >=1.2.13 
- zlib >=1.2.13 

**Important**: Do NOT clone the program with `git clone https://github.com/millanek/fineRADstructure`. It does not work well like that.

We also checked the possibility of installing fineradstructure directly (paying attention to the versions of the libraries). As it did not work either, we followed the next instructions. 

A new conda environment was created with the gsl program installed and activated it.

```
conda create -n finerstruct gsl
conda activate finerstruct
```
We installed the necessary libraries/programs and fineradstructure.
```
conda install -c anaconda libgcc-ng
conda install -c anaconda libgcc-ng=13.1
conda install -c anaconda libstdcxx-ng=13.1
conda install libzlib zlib -c conda-forge

conda install fineradstructure -c bioconda
```

This website helped us solve the errors encountered during the installation: https://github.com/millanek/fineRADstructure/issues/1

Once fineradstructure was installed, the *fineRADstructurePlot.R* and *FinestructureLibrary.R* files appeared in our folder.


## III) Step by step guidelines

The fineRADstructure analysis consisted of the following five steps:
1. Conversion of the dataset B from .vcf format to .finerad input format.
2. Calculation of the co-ancestry matrix.
3. Assignation of individuals to populations.
4. Building the tree.
5. Creating plots depicting the population structure.

**Important**: each command line (step) was executed on a different script or different line.

For help and further information for running fineRADstructure, refer to the documentation ... [linktodocumentation]


### 1. Conversion of dataset B from .vcf format to .finerad input format

The *finerad_convert_inputfile.sh* sbatch script was run.

```
RADpainter hapsFromVCF /dss/dsshome1/0A/ra93rey/fineradstruct/Alps_fmdi-geno50imiss70.recode.vcf
```

The output from sbatch resulted in the .finerad input file format for the next step. The name of the file  was changed. Here, it was altered to "Alps_dsB_paper".


### 2. Calculation of the co-ancestry matrix

The *finerad_coamatrix.sh* sbatch script was run.

```
RADpainter paint Alps_dsB_paper.finerad
```

The output file generated was *Alps_dsB_paper_chunks.out*, which served as the input file of the next step.


### 3. Assignment of the individuals to populations (MCMC step)

The *finerad_popasg.sh* sbatch script was executed.

```
finestructure -x 100000 -y 100000 -z 1000 Alps_dsB_paper_chunks.out Alps_dsB_paper_chunks.mcmc.xml
```
The output files included *Alps_dsB_paper_chunks.mcmc.xml*, one of the input files for the next step.


### 4. Creation of the clustering tree

The *finerad_treebuild.sh* sbatch script was run.

```
finestructure -m T -x 10000 Alps_dsB_paper_chunks.out Alps_dsB_paper_chunks.mcmc.xml Alps_dsB_paper_chunks.mcmcTree.xml
```
We obtained *Alps_dsB_paper_chunks.mcmcTree.xml* as output file.


### 5. Creation of the population structure plots

The R script *fineRADstructurePlot.R* was executed to obtain three types of plots:
- the simple coancestry matrix: *Alps_dsB_paper_frs-SimpleCoancestry.pdf*
- the populations and coancestry averages: *Alps_dsB_paper_frs-PopAveragedCoancestry.pdf*
- the populations and coancestry averages with perhaps more informatives labels: *Alps_dsB_paper_frs-PopAveragedCoancestry2.pdf*

To customize the plots, other software such as Inkscape were utilized.

The *Figure_fineRADstruct_paper.\*\*\** plot was obtained in pdf and svg format, depicting the populations and coancestry averages.


## IV) References

Malinsky, M., Trucchi, E., Lawson, D. J., & Falush, D. (2018). RADpainter and fineRADstructure: 
Population Inference from RADseq Data. Molecular Biology and Evolution, 35(5), 1284–1290. 
https://doi.org/10.1093/molbev/msy023

