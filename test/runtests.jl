#---------------------------------------------------------------
# Compute block averages starting from arbitrary intial data
# Soham 1/2019
#---------------------------------------------------------------

using DistributedPascal, Distributed

#=
# without futures
A = setinitialblockface(3)
B = computeblock(A)
C = getblockface(B)
D = computeblockgrid(3, 3)
=#

# with futures
addprocs(3)
@show nworkers(), nprocs()
@everywhere using DistributedPascal, Distributed
fD = fcomputeblockgrid(3, 3)
display(fetch.(fD)[1,1,1].val)
println()
