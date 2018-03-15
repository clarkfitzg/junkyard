
f = function(cl, a, b) list(cl, a, b)

f(1, 2, 3)

f(1, 2, c = 20)

library(parallel)

options(warnPartialMatchArgs = TRUE)
options(error = recover)

clu <- makeCluster(2, "PSOCK")

fun <- function(b, c) (b + c)

clusterApply(cl = clu, x = 1:2, fun = fun, c = 1) ## OK

# Yes, should be an error because of partial arg matching
clusterApply(clu, x = 1:2, fun = fun, c = 1) ## Error

# OK, this one fails for exactly the same reason as the one above because
# internally parLapply has this call:
# do.call(c, clusterApply(cl, x = splitList(X, length(cl)),
#     fun = lapply, fun, ...), quote = TRUE)
# so parLapply needs the fix the reporter suggested.

parLapply(cl = clu, X = 1:2, fun = fun, c = 1)




stopCluster(clu)
