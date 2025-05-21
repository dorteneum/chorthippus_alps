#!/bin/bash
#SBATCH --get-user-env
#SBATCH --clusters=biohpc_gen
#SBATCH --partition=biohpc_gen_normal
#SBATCH --cpus-per-task=20
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --mem-per-cpu=4763mb
#SBATCH --time=20:00:00
#SBATCH --job-name=finerad_allsteps
#SBATCH --output=finerad_allsteps
#SBATCH --error=finerad_allsteps_err

cd /dss/dsshome1/0A/ra93rey/fineradstruct

##Run each command line on a different script

#convert .vcf file from ipyrad to finerad input format (finerad_convert_inputfile.sh script).
RADpainter hapsFromVCF /dss/dsshome1/0A/ra93rey/fineradstruct/Alps_fmdi-geno50imiss70.recode.vcf

#The output from sbatch will be the finerad input format. Change the name of the file if necessary. Here we changed it to "Alps_dsB_paper".


#Calculate the co-ancestry matrix (finerad_coamatrix.sh script):
RADpainter paint Alps_dsB_paper.finerad


#Assign individuals to populations (run MCMC step) (finerad_popasg.sh script):
finestructure -x 100000 -y 100000 -z 1000 Alps_dsB_paper_chunks.out Alps_dsB_paper_chunks.mcmc.xml

#Tree building (finerad_treebuild.sh script):
finestructure -m T -x 10000 Alps_dsB_paper_chunks.out Alps_dsB_paper_chunks.mcmc.xml Alps_dsB_paper_chunks.mcmcTree.xml
