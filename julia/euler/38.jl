#using Logging

"""
Does x contain all the digits 1 through 9?

```julia-repl
julia> contains1to9("192384576")
true
```
"""
contains1to9 = function(x)
    for l in "123456789"
        if !occursin(l, x)
            return false
        end
    end
    true
end


"""
Multiply x with integers 1:n and concatenate resulting string.

```julia-repl
julia> concat_prod(192, 3)
"192384576"
```
"""
concat_prod = function(x, n)
    p = x * Array(1:n)
    p = map(string, p)
    *(p...)
end

@code_warntype concat_prod(192, 3)

