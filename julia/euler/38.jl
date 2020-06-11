using Logging

is_9pandigital = function(x)::Bool
    # Maybe this Set is messing things up?
    digits = Set(string(x))
    length(digits) == 9
end


find_largest = function(lower, upper, product, largest_known)
    for i in lower:upper
        candidate = i * product
        if is_9pandigital(candidate)
            largest_known = max(candidate, largest_known)
        end
    end
    largest_known
end


# Appears type safe
# Doesn't work anymore?
@code_warntype is_9pandigital(123)


@code_warntype find_largest(100, 200, 3, 101)




largest_pandigital = function(n = 2, old_product = 1, largest_known = 918273645, upper_bound = 1e10)
    @info n
    product = n * old_product

    # We only need to search between largest_known and upper_bound
    lower = Integer(ceil(largest_known / product))
    upper = Integer(floor(upper_bound / product))

    if upper <= lower
        return largest_known
    end

    largest_known = find_largest(lower, upper, product, largest_known)

    largest_pandigital(n = n + 1, old_product = product, largest_known = largest_known)
end


@code_warntype largest_pandigital()
