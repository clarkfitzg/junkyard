
f = function(cl, a, b) list(cl, a, b)

f(1, 2, 3)

f(1, 2, c = 20)

library(parallel)

clu <- makeCluster(2, "PSOCK")

fun <- function(x0, x1) (x0 + x1)
clusterApply(clu, x = 1:2, fun = fun, x1 = 1) ## OK
parLapply(cl = clu, X = 1:2, fun = fun, x1 = 1) #OK


fun <- function(b, c) (b + c)

# Yes, should be an error because of partial arg matching
clusterApply(clu, x = 1:2, fun = fun, c = 1) ## Error

clusterApply(cl = clu, x = 1:2, fun = fun, c = 1) ## OK

# But this one should work just like the one above
parLapply(cl = clu, X = 1:2, fun = fun, c = 1) ## Error

# Ask Nick.

stopCluster(clu)
