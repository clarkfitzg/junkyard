#Rscript timers.R --vanilla firstone second 3

args = commandArgs(trailingOnly=TRUE)

library(microbenchmark)

microbenchmark({
    rnorm(100)
})

print(args)

print(class(args))
