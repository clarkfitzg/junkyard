is_9pandigital = function(x)
    digits = Set(string(x))
    length(digits) == 9
end


largest_pandigital = function(n = 2, old_product = 1, largest_known = 918273645, upper_bound = 1e10)
    product = n * old_product

    # We only need to search between largest_known and upper_bound
    lower = ceil(largest_known / product)
    upper = floor(upper_bound / product)

    if upper <= lower
        return largest_known
    end

    for i in lower:upper
        candidate = i * prod
        if is_9pandigital(candidate)
            largest_known = max(candidate, largest_known)
        end
    end

    largest_pandigital(n = n + 1, old_product = product, largest_known = largest_known)
end
