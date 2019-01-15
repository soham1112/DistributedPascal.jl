#---------------------------------------------------------------
# Compute block averages starting from arbitrary intial data
# Soham 1/2019
#---------------------------------------------------------------

struct Block
    val::Array{Number, 3}
end

struct BlockFace
    val::Array{Number, 2}
end

function Base. size(A::T) where {T<:Union{BlockFace, Block}}
    return size(A.val)[1]
end

function Base. getindex(B::Block, i::Int, j::Int, k::Int)::Number
    i = i > size(B) ? i - size(B) : (i < 1 ? size(B) + i : i)
    j = j > size(B) ? j - size(B) : (j < 1 ? size(B) + j : j)
    k = k > size(B) ? k - size(B) : (k < 1 ? size(B) + k : k)
    return B.val[i,j,k]
end

function Base. getindex(B::BlockFace, i::Int, j::Int)::Number
    i = i > size(B) ? i - size(B) : (i < 1 ? size(B) + i : i)
    j = j > size(B) ? j - size(B) : (j < 1 ? size(B) + j : j)
    return B.val[i,j]
end

function Base. setindex!(B::Block, u::Number, i::Int, j::Int, k::Int)::Block 
    B.val[i,j,k] = u
    return B
end

function computeblock(face::BlockFace)::Block
    B = Block(zeros(Number, size(face), size(face), size(face)))
    for k in 1:size(face), j in 1:size(face), i in 1:size(face)
        if k == 1
            B[i,j,k] = face.val[i,j]
        else
            B[i,j,k] = (B[i, j+1, k-1] + B[i, j-1, k-1] 
                      + B[i+1, j, k-1] + B[i-1, j, k-1])/B[i, j, k-1]
        end
    end
    return B 
end

function setinitialblockface(size::Int)
    return BlockFace(rand(1:10, (size, size)))    
end

function getblockface(B::Block)::BlockFace
    return BlockFace(B.val[:, :, end])
end
