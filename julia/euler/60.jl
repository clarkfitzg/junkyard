using Primes

"""
```julia-repl
julia> pair_concat_prime(7, 109)
true

julia> pair_concat_prime(7, 2)
false
```
"""
pair_concat_prime = function(p1, p2)
    p1s = string(p1)
    p2s = string(p2)
    p1p2 = parse(Int, p1s * p2s)
    p2p1 = parse(Int, p2s * p1s)
    isprime(p1p2) & isprime(p2p1)
end


# 
pairs_for_p = function(p, candidates)
    (c for c in candidates if pair_concat_prime(p, c))
end


# Arbitrary upper bound, let's hope it works 😬
build_pairs = function(upper = 10_000)

    # 2 cannot be in this set, since any number ending in 2 is not prime (besides 2).
    candidates = primes(3, upper)

    d = Dict()
    for (i, p) in Iterators.enumerate(candidates)
        larger_candidates = candidates[(i+1):end]
        d[p] = Set(c for c in larger_candidates if pair_concat_prime(p, c))
    end
    d
end


# All of these numbers are pairs
@time pairs = build_pairs()

# This is an undirected graph, where the nodes are the primes and the edges represent the prime concatenation property.
# The next step is to find all the fully connected subgraphs with 5 nodes.
# I wish there was an easy off the shelf implementation for this.
# Probably won't be too difficult to do the nongeneral case though.

# Is it possible to reuse this data structure?
# I think so.
# Let p0 be the candidate prime, connected to p1, ..., pn
# To see if pk can possibly be in a fully connected 5 group with p0, no, I see a better way.

# There aren't very many numbers to check.
# sum(map(length, values(pairs)))
# 18176

# All those that have fewer than 4 elements cannot be in this set.

# Suppose we represent the graph with a (sparse) matrix.
# To find the fully connected subcomponents, we just need to get the graph into a form with diagonal blocks:
# AD, where A is a permutation matrix.
