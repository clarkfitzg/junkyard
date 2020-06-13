"""
```julia-repl
julia> pythagorean_triplet(3, 4, 5)
true

julia> pythagorean_triplet(3, 4, 6)
false
```
"""
pythagorean_triplet = function(a, b, c)
    a, b, c  = sort([a, b, c])
    a^2 + b^2 == c^2
end


find_triple = function(total = 1000)
    # Only iterating over integers a, b, c that sum to total
    for a in 1:(total - 2)
        for b in 1:(total - a - 1)
            c = total - a - b
            if pythagorean_triplet(a, b, c)
                return a, b, c
            end
        end
    end
end

prod(find_triple())
