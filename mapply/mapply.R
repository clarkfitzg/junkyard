x = 1:3
y = c("a", "b")
xy = expand.grid(x, y)
names(xy) = c("x", "y")


f = function(x, y)
{
    ans = "TODO - actually compute something :)"

    # Save results in case of crash
    saveRDS(ans, paste0(x, "_", y, ".rds"))

    # Return results
    list(x, y, ans)
}



# Serial
r1 = Map(f, xy$x, xy$y)

# Parallel
library(parallel)

# You can use 20 on the cluster
ncores = 2L

cls = makeCluster(ncores)

r2 = clusterMap(cls, f, xy$x, xy$y)
