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
