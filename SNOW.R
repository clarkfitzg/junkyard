# Mon Aug 15 09:35:32 KST 2016
# 
# Is there a common abstraction for using apply with the parallel backend?
# Yes. So lets use it.

library(parallel)

x1 = list(1:10, letters, rnorm(5))
x2 = list(101:110, LETTERS, rnorm(5))

expensive_function <- function(...){
system.time({
    bigmatrix <- matrix(rnorm(4e6L), nrow=2e3L)
    solve(bigmatrix)
})
}

cl_PSOCK <- makeCluster(3L, "PSOCK")

clusterMap(cl_PSOCK, expensive_function, x1, x2)

cl_FORK <- makeCluster(3L, "FORK")

clusterMap(cl_FORK, expensive_function, x1, x2)
