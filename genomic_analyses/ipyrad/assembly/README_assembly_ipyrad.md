# 1. De novo assembly

After preparing and sequencing the ddRADseq libraries, we utilized the ipyrad v 3.10 pipeline to generate a de novo assembly and infer genotyping.


## I) Installation




## II) Files in this folder

- *README_assembly_ipyrad.md*: README file for the ipyrad assembly
- *params-alps_all_T.txt*: parameters file for running the assembly

## III) Step by step guidelines

To generate the de novo assembly, we followed these steps:
1. Create a new params file.
2. Edit the params file accordingly.
3. Run the de novo assembly.

For getting help or/and want to know more about all the parameters options to run the assembly, run `ipyrad -h` and go to the documentation https://ipyrad.readthedocs.io


### 1. Creation of a new params file

We created the params file *params-alps_all_T.txt* named alps_all_:
`ipyrad -n alps_all_T`


### 2. Modification of the params file
We used a text editor to edit the parameter settings in *params-alps_all_T.txt*. In our case, the sequenced data is demultiplexed without allowing any mismatches on individual barcodes or adapters ([16] filter_adapters = 2) and removing reads with too many ambiguous bases ([5] max_low_qual_bases = 5). As no reference genome is available for these species, we generated a de novo assembly. We selected the minimum number of samples required to call a locus ([21] min_samples_locus = 4) and the threshold of sequence similarity to form a cluster ([14] clust_threshold = 0.88). Finally, we inferred genotyping through consensus base calling. For the rest of parameters, we left the default values of ipyrad.


### 3. Running the de novo assembly

The de novo assembly consisted of 7 steps:
1. Demultiplexing/loading fastqc files
2. Filtering/editing reads
3. Clustering/Mapping reads within samples and alignment
4. Joint estimation of heterozygosity and error rate
5. Consensus base calling and filtering
6. Clustering/Mapping reads among samples and alignment
7. Filtering and formatting output files

Once the params file was edited, we can run all the steps of the assembly at once or by parts.

Running steps 1-2 of assembly (-s is the set of assembly steps to run)
`ipyrad -p params-alps_all_T.txt -s 12`

Running the remaining steps 3-7
`ipyrad -p params-alps_all_T.txt -s 34567`



Other example command-line usage: 

- Create a new "params-data.txt" parameters file: `ipyrad -n data`
- Run only steps 1-3 of the assembly: `ipyrad -p params-data.txt -s 123`
- Run step 3, overwrite existing data: `ipyrad -p params-data.txt -s 3 -f` 
- HPC parallelization across 32 cores: `ipyrad -p params-data.txt -s 3 -c 32 --MPI`
- Print results (summary): `ipyrad -p params-data.txt -r`
- Branch/Merge Assemblies: `ipyrad -p params-data.txt -b newdata` / `ipyrad -m newdata params-1.txt params-2.txt [params-3.txt, ...]`
- Subsample taxa during branching: `ipyrad -p params-data.txt -b newdata taxaKeepList.txt`
- Download sequence data from SRA into directory 'sra-fastqs/': `ipyrad --download SRP021469 sra-fastqs/ `


## III) Datasets

The dataset obtained after the assembly is:
- **Raw dataset**
  - File name: *Alps_1_nomismatchedind.recode.vcf*
  - Folder: paper_final_datasets/vcf_filtering/step1_2/
  - Path: paper_final_datasets/vcf_filtering/step1_2/Alps_1_nomismatchedind.recode.vcf
  - Analyses using this data set: none


### IV) References

Eaton, D. A. R., & Overcast, I. (2020). ipyrad: Interactive assembly and analysis of RADseq datasets. Bioinformatics, 36(8), 2592–2594. https://doi.org/10.1093/bioinformatics/btz966

