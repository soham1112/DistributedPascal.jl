#!/bin/bash
#SBATCH --job-name="JuliaDistributedTest"
#SBATCH --output="distributed.%j.%N.out"
#SBATCH --partition=debugq
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=40
#SBATCH -t 00:01:00

set -euxo pipefail

module load slurm
module load julia

pwd
echo "SLURM_JOB_ID=$SLURM_JOB_ID"
date

# Create a file with the host names of all the nodes assigned to this
# job. List each host 40 ($SLURM_CPUS_ON_NODE) times.
machinefile=$(mktemp)
seq $SLURM_CPUS_ON_NODE |
    xargs -n 1 -I '{}' scontrol show hostnames |
    sort >$machinefile

echo "AAA"
cat $machinefile
echo "BBB"
hostname
for host in $(cat $machinefile); do
    echo $host
    ssh -o StrictHostKeyChecking=no $host hostname
done
echo "CCC"

julia --machine-file $machinefile  -e '@everywhere using Pkg; 
                                       @everywhere Pkg.activate(".");
                                       @everywhere using DistributedPascal;
                                       D = fcomputeblockgrid(3,3);
                                       @show fetch.(D)'
date
