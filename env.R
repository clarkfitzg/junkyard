# From r-devel list question

library(parallel)
env1 <- new.env()
env1$x = 0
cl <- makeCluster(2, type="FORK")

# All the same address
parLapply(cl, 1:4, function(x) capture.output(str(env1)))

# Now we write to the environment, and env1$x has two distinct values
clusterEvalQ(cl, env1$x <- rnorm(1))
# [[1]]
# [1] -1.296702
# 
# [[2]]
# [1] -0.4001104

# The environments in the 2 child processes still have the same address,
# which is the same as the original address
parLapply(cl, 1:4, function(x) capture.output(str(env1)))
env1

# The original x is unchanged
env1$x

stopCluster(cl)
