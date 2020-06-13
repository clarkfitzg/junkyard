import IterTools

"""
Check if a number is a palindrome

```julia-repl
julia> palindrome(12321)
true

julia> palindrome(1234)
false
```
"""
palindrome = function(n)
    ns = string(n)
    ns == reverse(ns)
end


max_pal_product = function(x = 100:999)
    mx = 0
    for a in x
        # Could cut computation in half by only iterating up to b here
        for b in x
            ab = a*b
            if palindrome(ab)
                mx = max(mx, ab)
            end
        end
    end
    mx
end


max_pal_product()


max_pal_product2 = function(x = 100:999)
    p = (a*b for a in x for b in x)
    # Unfortunately, filter doesn't seem to be an iterator, and this isn't working like I hoped.
    p2 = filter(palindrome, p)
end


# It would be more elegant to do this with a call like:
# p = cartesian_prod(x, x)
# p2 = map(*, p)
# p3 = filter(palindrome, p2)
# mx = max(p3)


