#!/bin/bash -l
#SBATCH --job-name=emupca
#SBATCH --output=emu_output_%j
#SBATCH --error=emu_error_%j

#last modified: 29.11.24

## NOTE: FILES MUST BE IN PLINK FORMAT TO RUN THIS SCRIPT

#timestamp init 
STARTTIME=$(date +"%s")
echo " Job started at $(date)."

EMU_ALPS_IN="PATH/TO/PLINK_FILES"
EMU_ALPS_OUT="PATH/TO/OUTPUT_DIRECTORY"

conda run -n emu emu -p $EMU_ALPS_IN -o $EMU_ALPS_OUT -f 0.0025 -e 11 -t 40 --iter  500
#one can also remove the iteration flag and let the program run alone until conversion

#timestamp end
ENDTIME=$(date +%s)
TIMESPEND=$(($ENDTIME - $STARTTIME))
((sec=TIMESPEND%60, TIMESPEND/=60, min=TIMESPEND%60, hrs=TIMESPEND/60))
timestamp=$(printf "%d:%02d:%02d" $hrs $min $sec)
echo "Job ended at $(date). Took $timestamp hours:minutes:seconds to complete."
