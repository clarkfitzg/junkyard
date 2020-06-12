using Debugger

using Primes
using Combinatorics: combinations


"""
Replace the digits in x[loc] = d

```
julia> replace_digits(11111, 9, [2, 4])
19191
```
"""
replace_digits = function(x, d, loc)
    x, d = string(x), string(d)[1]
    x = collect(x)
    x[loc] .= d
    parse(Int, join(x))
end


"""
Test if prime number x is a member of an n prime value family

```
julia> n_prime_value_family(56003, 7)
true

julia> n_prime_value_family(56003, 8)
false
```
"""
n_prime_value_family = function(x, n = 8)
    xd = collect(string(x))
    alldigits = map(x -> string(x)[1], 0:9)

    for index in combinations(1:length(xd))
        xi = copy(xd)
        nprimes = 0
        for d in alldigits
            xi[index] .= d
            if xi[1] == '0'
                # Not a valid integer
                continue
            end
            candidate = parse(Int, join(xi))
            if isprime(candidate)
                nprimes += 1
                if nprimes == n
                    @bp
                    return true
                end
            end
        end
    end
    false
end

#@enter n_prime_value_family(13, 7)


find_first_n_prime = function(n = 8)
    p = 2
    while !n_prime_value_family(p, n)
        p = nextprime(p, 2)
    end
    p
end


if false

    # This call works, finding 56003
    find_first_n_prime(7)

    # This doesn't work, no idea why.
    find_first_n_prime(8)

    @run n_prime_value_family(120383)

end
