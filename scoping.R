# Understanding R's scoping rules

f_outer = function(x)
{
    y = 10
    x
}

f_inner = function(x)
{
    x + y
}

# Fails
f_outer(f_inner(10))
