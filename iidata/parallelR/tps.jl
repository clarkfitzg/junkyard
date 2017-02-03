
# Clark: Going to run this on Pearson and maybe write the reduce
# Sun Jan 22 14:07:16 PST 2017
#
# I see the same 50x speedup from pure Julia here.
# 
#                                          o8o                                   .o
#                                          `"'                                 .d88
# oooo    ooo  .ooooo.  oooo d8b  .oooo.o oooo   .ooooo.  ooo. .oo.          .d'888
#  `88.  .8'  d88' `88b `888""8P d88(  "8 `888  d88' `88b `888P"Y88b       .d'  888
#   `88..8'   888ooo888  888     `"Y88b.   888  888   888  888   888       88ooo888oo
#    `888'    888    .o  888     o.  )88b  888  888   888  888   888            888
#     `8'     `Y8bod8P' d888b    8""888P' o888o `Y8bod8P' o888o o888o          o888o
#
#

# The biggest speed up I can get is a factor of 50 on pearson...seems like it should be more


using OpenCL, BenchmarkTools


# command line input
if (length(ARGS) == 0)
    NTERMS_TPS = 10
    NTERMS_SUM = 10
else
    NTERMS_TPS = parse(Int32, ARGS[1])
    NTERMS_SUM = parse(Int32, ARGS[2])
end


kernel_src = open("partial_sum_tps.cl") do f
   readstring(f)
end


# --- GPU version
function closure_ll_gpu(knots, coefficients, nterms_tps, nterms_sum)

    n = Int32(length(knots))
    nterms_tps = Int32(nterms_tps)
    nterms_sum = Int32(nterms_sum)
    threads_tps = Int32(div(n, nterms_tps))
    threads_sum = Int32(div(n, nterms_sum))

    device, ctx, queue = cl.create_compute_context()

    knots_clbuff = cl.Buffer(Float32, ctx, (:r, :copy), hostbuf = knots)
    coefficients_clbuff = cl.Buffer(Float32, ctx, (:r, :copy), hostbuf = coefficients)
    intermediate_clbuff = cl.Buffer(Float32, ctx, :rw, n)
    partial_sums_clbuff = cl.Buffer(Float32, ctx, :w, threads_sum)

    program = cl.Program(ctx, source = kernel_src) |> cl.build!
    tps_kernel = cl.Kernel(program, "tps")
    sum_kernel = cl.Kernel(program, "sum")

    function ll_gpu(Θ)
        queue(tps_kernel, threads_tps, nothing
                      , Float32(Θ)
                      , knots_clbuff
                      , coefficients_clbuff
                      , intermediate_clbuff
                      )
        queue(sum_kernel, threads_sum, nothing
                      , intermediate_clbuff
                      , partial_sums_clbuff
                      , nterms_sum
                      )
        ll::Vector{Float32} = cl.read(queue, partial_sums_clbuff)
        return sum(ll)
    end

    return ll_gpu::Function
end

# --- pure julia implimentation
function closure_ll_julia(knots, coefficients)
    function ll_julia(Θ)
        Θ = Float32(Θ)
        total = Float32(0)
        @inbounds @simd for i in eachindex(knots)
            r  = abs(Θ - knots[i])
            total += coefficients[i] * r * r * log(r)
        end
        return total
    end
    return ll_julia::Function
end



# initalize knots and coefficients on host

target_n = 10_000_000

# n must be divisible by NTERMS_TPS. To generalize the above funcs it would be best
# to pad the arrays, since checks and branching in the kernel kills speed

n = div(target_n, NTERMS_TPS) * NTERMS_TPS

# Clark: Answer depends on NTERMS_TPS because n may be different
srand(37)
knots = Float32.(rand(n))
coefficients = Float32.(randn(n))

ll_gpu = closure_ll_gpu(knots, coefficients, NTERMS_TPS, NTERMS_SUM)
ll_julia = closure_ll_julia(knots, coefficients)

x = 0.22

llx_gpu = ll_gpu(x)
llx_julia = ll_julia(x)

b = @benchmark ll_gpu(x)

print("------------------------------------------------------------\n")
print("\n")
print("Pure julia answer:   $llx_julia\n")
print("GPU answer:          $llx_gpu\n")
print("\n")
print("n                    $n\n")
print("Number of TPS terms: $NTERMS_TPS\n")
print("Sum terms:           $NTERMS_SUM\n")
print("\n")
print(b)
print("\n")
print("\n")


if(false)

    # With n ~ 1e7 and Float32 on pearson this takes 140 ms
    @benchmark ll_julia(x)

end
