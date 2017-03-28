"""
Email conversation with Ethan...

This is a piece of code I just wrote for another project that lives within
another loop. Each line is fused and expands to it’s own fast loop over
indices. However, all matrices are exactly the same size so I can do some extra
work and fuse everything with one big loop with bounds checking turned off and
simd turned on. It seems to me that your code inference could detect that it is
safe and fuse the whole code block.
"""

for ...

    M̃[1,1] .= ∇∇ϕ[2,2]
    M̃[1,2] .= .- ∇∇ϕ[1,2]
    M̃[2,2] .= ∇∇ϕ[1,1]
    M̃[2,1] .= M̃[1,2]

    M̃∇ϕ[1] .= M̃[1,1].*∇ϕ[1] .+ M̃[1,2].*∇ϕ[2]
    M̃∇ϕ[2] .= M̃[2,1].*∇ϕ[1] .+ M̃[2,2].*∇ϕ[2]

    M̃∇δϕ[1] .= M̃[1,1].*∇δϕ[1] .+ M̃[1,2].*∇δϕ[2]
    M̃∇δϕ[2] .= M̃[2,1].*∇δϕ[1] .+ M̃[2,2].*∇δϕ[2]

    ∇∇δϕ∇ϕ[1] .= ∇∇δϕ[1,1].*∇ϕ[1] .+ ∇∇δϕ[1,2].*∇ϕ[2]
    ∇∇δϕ∇ϕ[2] .= ∇∇δϕ[2,1].*∇ϕ[1] .+ ∇∇δϕ[2,2].*∇ϕ[2]

    for k=1:2, p=1:2
        B[1] .+= ∇∇δϕ[p,k] .* M̃[1,p] .* ∇ϕ[k] .+ M̃[p,k] .* ∇∇δϕ[1,p] .* ∇ϕ[k]
        B[2] .+= ∇∇δϕ[p,k] .* M̃[2,p] .* ∇ϕ[k] .+ M̃[p,k] .* ∇∇δϕ[2,p] .* ∇ϕ[k]
        for q=1:2
            C[1] .+= M̃[1,p] .* M̃[q,k] .* ∇∇δϕ[p,q] .* ∇ϕ[k]
            C[2] .+= M̃[2,p] .* M̃[q,k] .* ∇∇δϕ[p,q] .* ∇ϕ[k]
        end
    end

    ...

end
