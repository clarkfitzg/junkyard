code_swapper = function(expr, ...)
{
    e = substitute(expr)
    do.call(substitute, list(e, list(...)))
}


code_swapper2 = function(expr, env)
{
    e = substitute(expr)
    do.call(substitute, list(e, env))
}



code_swapper(x + 5, x = quote(y))

code_swapper(x + 5, x = quote(sin(x) + 400))

code_swapper2(x + 5, list(x = quote(y)))
