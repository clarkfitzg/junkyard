library(cluster)
# Read in the data

distances = read.table("~/scratch/EuclideanD.txt",dec = ",")
distances = as.matrix (distances)
distances = as.dist (distances)

# fitting the clustering model pam
set.seed (89473)
clustering1 = pam(distances,5)

# plotting
plot(clustering1)

s = silhouette(clustering1)

width = s[, "sil_width"]

# Names show the indices of outlying points
width[width < 0]

?clara

# Hierarchical clustering
ag = agnes(distances,5)

# plotting
plot(ag)



# Example spline fitting

n = 100
x = seq(from = 0, to = pi, length.out = n)
ytrue = sin(x)
plot(x, ytrue, type = "l")
ynoisy = ytrue + 0.05 * rnorm(n)
lines(x, ynoisy, col = "red")
sp = smooth.spline(x, ynoisy)
lines(x, sp$y, col = "blue")
