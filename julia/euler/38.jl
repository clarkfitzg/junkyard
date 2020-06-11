#using Logging
using Debugger

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


largest_pandigital = function(largest_known = 918273645)
    for x in 1:Int(1e4)
    #for x in 1:1e4
        for n in 2:9
            candidate = concat_prod(x, n)
            l = length(candidate)
            if l < 9
                continue
            end
            if 9 < l
                # Larger values of n will also have too many characters
                break
            end
            # It's 9 characters:
            if contains1to9(candidate)
                pd = parse(Int, candidate)
                #@bp
                largest_known = max(pd, largest_known)
            end
        end
    end
    largest_known
end


@code_warntype largest_pandigital()

@time largest_pandigital()

#@run largest_pandigital()
