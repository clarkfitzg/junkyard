# Will we see a speedup using threads in Julia?
# First run this in bash:
#
# export JULIA_NUM_THREADS=2

using Base.Threads
using BenchmarkTools


function f_ser!(x, y)
    for i in 1:length(x)
        y[i] = 2 * x[i]
    end
end


function f_par!(x, y)
    Threads.@threads for i in 1:length(x)
        y[i] = 2 * x[i]
    end
end


n = 1_000

x = randn(n)
x2 = randn(5*n)
x3 = randn(5*5*n)

y = similar(x)
y2 = similar(x2)
y3 = similar(x3)


# 8 microseconds serial, 11 microseconds threaded
@benchmark f_ser!(x, y)
@benchmark f_par!(x, y)

# 40 microseconds serial, 55 microseconds threaded
@benchmark f_ser!(x2, y2)
@benchmark f_par!(x2, y2)

# 250 microseconds serial, 300 microseconds threaded
@benchmark f_ser!(x3, y3)
@benchmark f_par!(x3, y3)
