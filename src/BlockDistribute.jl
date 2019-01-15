#---------------------------------------------------------------
# Compute block averages starting from arbitrary intial data
# Soham 1/2019
#---------------------------------------------------------------

function computeblockgrid(numblocks::Int)
    grid = Array{Union{Nothing, Block}}(nothing, (numblocks, numblocks, numblocks))
    for i in 1:numblocks, j in 1:numblocks, k in 1:numblocks
        if k == 1
            grid[i,j,k] = computeblock(setinitialblockface(3)) 
        else
            grid[i,j,k] = computeblock(getblockface(grid[i,j,k-1]))
        end
    end
    return grid
end
