#---------------------------------------------------------------
# Compute block averages starting from arbitrary intial data
# Soham 1/2019
#---------------------------------------------------------------

function fsetinitialblockface(size::Int)::Future
    @spawn setinitialblockface(size)
end

function fgetblockface(fblock::Future)::Future
    @spawn getblockface(fetch(fblock))
end

function fcomputeblock(fblockface::Future)::Future
    @spawn computeblock(fetch(fblockface))
end

function fcomputeblockgrid(numblocks::Int)
    fgrid = Array{Union{Nothing, Future}}(nothing, (numblocks, numblocks, numblocks))
    for i in 1:numblocks, j in 1:numblocks, k in 1:numblocks
        if k == 1
            fgrid[i,j,k] = fcomputeblock(fsetinitialblockface(3)) 
        else
            fgrid[i,j,k] = fcomputeblock(fgetblockface(fgrid[i,j,k-1]))
        end
    end
    return fgrid
end

