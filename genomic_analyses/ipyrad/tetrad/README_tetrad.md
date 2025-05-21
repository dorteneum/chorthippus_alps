# 7. Phylogenetic analysis

To understand how song and wing morphology changes along the species tree, we inferred the phylogenetic relationships between all individuals. The tree was produced as implemented by tetrad within the ipyrad toolkit, employing the SDVquartets algorithm (Chifman & Kubatko, 2014). Tetrad v.0.9.13 accounts for missing data present in the dataset and resolves quartet trees from SNPs, which were then joined together into a supertree using the gQMC algorithm (Avni et al., 2015). 

[Tetrad v.0.9.13 was run with a non-parametric bootstrap of 1,000 iterations and a majority rule consensus tree was constructed from the outputs. The tree was rooted at the *C. mollis mollis* clade as it exhibited the highest differentiation among our sampled species based on FST values (Nolen et al., 2020). ]

For this analysis, we used **dataset B** (*Alps_fmdi-geno50imiss70.recode.vcf*).


## I) Files in this folder

- *README_tetrad.md*: Detailed intructions for the phylogenetic analysis run with tetrad.
- *tetrad_script.ipynb*: Interactive Python notebook with step by step guidelines for the phylogenetic analysis.
- **analysis-vcf2hdf5** folder: 
  - *Alps_DSB_paper.snps.hdf5*: Dataset B in hdf5 format.
- **analysis-tetrad** folder:
  - *tetrad_DSB_paper.\**: Output files generated after running tetrad.
- *tree_paper_plot_allbootstrap_bootstrap1000.svg*: Phylogenetic tree showing bootstrap iterations in SVG format.
- *tree_paper_plot_consensus_bootstrap1000.svg*: Consensus phylogenetic tree in SVG format.


## II) Installation

A new empty conda environment (named "tetrad_4") was created. Once the environment was activated, we installed python, ipyrad and tetrad:
```
conda install -c conda-forge -c bioconda -c eaton-lab python=3.7.0 ipyrad tetrad
```
Additionally, "ipykernel" was installed to use the new environment as a kernel:
```
conda install ipykernel

python -m ipykernel install --user --name=tetrad_4
```

As we encountered the error "urllib3 v2.0 only supports OpenSSL 1.1.1+...", we attempted to install Openssl version 1.1.1. However, this approach was unsuccessful due to the requirement for python 3.7.0. The solution that worked was installing urllib3 version 1.24.
```
conda install urllib3=1.24
```


## III) Step by step guidelines

As our dataset B file was very heavy, the memory usage for tetrad needed to be limited by reducing the number of cores to increase the available RAM for each job. This was necessary to prevent crashes while running. On the command line, we launched an ipcluster, for instance, 10 cores:
```
ipcluster start -n 10 --cluster-id=tetrad_10 --daemonize
```

We opened the interactive python notebook file *tetrad_script.ipynb* and selected the conda environment "tetrad_4" as the Kernel. We followed the guidelines in this file.

For help or further information about tetrad software within ipyrad, refer to the documentation at: 
https://toytree.readthedocs.io/en/latest/index.html 

The GitHub repository is available at: 
https://github.com/eaton-lab/tetrad/tree/master 
https://github.com/dereneaton/ipyrad/blob/master/docs/tetrad.rst 

Moreover, some cookbooks are accesible via: 
https://notebook.community/dereneaton/ipyrad/tests/cookbook-tetrad 

To customize and root the tree at the midpoint we used FigTree.

## IV) References

Avni, E., Cohen, R., & Snir, S. (2015). Weighted Quartets Phylogenetics. Systematic Biology, 64(2), 233–
1.   https://doi.org/10.1093/sysbio/syu087

Chifman, J., & Kubatko, L. (2014). Quartet Inference from SNP Data Under the Coalescent Model. 
Bioinformatics, 30(23), 3317–3324. https://doi.org/10.1093/bioinformatics/btu530
