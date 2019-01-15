#---------------------------------------------------------------
# Compute block averages starting from arbitrary intial data
# Soham 1/2019
#---------------------------------------------------------------

using DistributedPascal

# without futures
A = setinitialblockface(3)
B = computeblock(A)
C = getblockface(B)
D = computeblockgrid(3)

# with futures
fA = fsetinitialblockface(3)
fB = fcomputeblock(fA)
fC = fgetblockface(fB)
fD = fcomputeblockgrid(3)

@show D
@show fetch.(fD)
