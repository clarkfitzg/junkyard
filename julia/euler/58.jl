using Statistics
using Primes


square_spiral = function(threshold = 0.1)
    bottomright = 9
    nprimes = 3
    ntotal = 4
    # Size of the square
    n = 3
    while(threshold < nprimes / ntotal)
        from = bottomright + n + 1
        next4 = from:(n+1):(from+3n+3)

        # Updates for next iteration
        bottomright = next4[end]
        nprimes += count(isprime, next4)
        ntotal += 4
        n += 2
    end
    n
end

square_spiral()
