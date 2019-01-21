#---------------------------------------------------------------
# Compute block averages starting from arbitrary intial data
# Soham 1/2019
#---------------------------------------------------------------

module DistributedPascal

using Distributed, ClusterManagers

export Block, BlockFace
export computeblock,   setinitialblockface,  getblockface 
export fcomputeblock, fsetinitialblockface, fgetblockface 
export computeblockgrid, fcomputeblockgrid

include("BlockAverage.jl")
include("BlockDistribute.jl")
include("BlockFutures.jl")

end
