# Will we see a speedup using threads in Julia?
# First run this in bash:

# export JULIA_NUM_THREADS=4

using Base.Threads
using BenchmarkTools


function f(xi)
    return sin(cos(xi + 20))
    #return 2 * xi
end


function f_ser!(x, y)
    for i in eachindex(x)
        y[i] = f(x[i])
    end
end


function f_par!(x, y)
    Threads.@threads for i in eachindex(x)
        y[i] = f(x[i])
    end
end


n = 100

x = randn(n)
x2 = randn(5*n)
x3 = randn(5*5*n)

y = similar(x)
y2 = similar(x2)
y3 = similar(x3)

# Running this on my desktop which has 2 cores (maybe hyperthreading?)

# About 1.5x improvement
@benchmark f_ser!(x, y)
@benchmark f_par!(x, y)

# About 2x improvement
@benchmark f_ser!(x2, y2)
@benchmark f_par!(x2, y2)

# About 2.5x improvement
@benchmark f_ser!(x3, y3)
@benchmark f_par!(x3, y3)
