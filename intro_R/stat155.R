# 3 Mar 2020
#
# Intro to R for STAT 155 class, substituting for Jas Pannu

# Clark Fitzgerald

# Some nice lessons from Software Carpentry:
# https://software-carpentry.org/lessons/

# More on R:
# https://bookdown.org/rdpeng/rprogdatascience/

# Vectors and basic data types

true_p = 0.7
# setting the seed guarantees reproducible results
set.seed(2487)
x = rbinom(10, 1, true_p)

x[9]

typeof(x)

# Let's estimate p
p_hat = mean(x)

# Simulating

# Plotting
n = 100
x = rbinom(n, size = 3, prob = true_p)

plot(table(x))

h = hist(x)

str(h)

# Arithmetic


# Models

# Packages
# Install with
install.packages("ggplot2")

library(ggplot2)

x = 1:10
y = runif(10)

y_without_last2 = y[-c(9, 10)]

# type coercion
z = c(1, 2L, 3.14159, "hello")

# NA is for missing values
z[2] = NA
z2 = NA

is.na(z2)

# This is an example of vectorization, that is, 
# R doing the looping implicitly for you.
is.na(z)

length(y_without_last2)

qplot(x, y)

# Random stuff!
set.seed(542893)

# Random walk
random_walk = function(n = 100)
{
  x0 = rnorm(n)
  x = cumsum(x0)

  y0 = rnorm(n)
  y = cumsum(y0)

  plot(x, y, type = "l")
}

random_walk(500)






# Drop the bomb!
rm(list = ls())

# A 2d random walk
directions = c("north", "east", "south", "west")



# Take a single step in one direction
step = function(position, direction)
{
  if(direction == "north"){
    position$y = position$y + 1L
  } else if(direction == "east"){
    position$x = position$x + 1L
  } else if(direction == "south"){
    position$y = position$y - 1L
  } else if(direction == "west"){
    position$x = position$x - 1L
  }
  position
}

# Plot a single step
plot_step = function(from, to)
{
  arrows(from$x, from$y, to$x, to$y, length = 0.1)
}

# Run an entire simulation
simulate = function(position = list(x = 0, y = 0),
                    pause = 0.2, bounds = 10,
                    nsteps = bounds * 10)
{
  b = c(-bounds, bounds)
  plot(b, b, type = "n")
  walk = sample(directions, nsteps, replace = TRUE)
  to = position
  for(d in walk){
    from = to
    to = step(from, d)
    plot_step(from, to)
    Sys.sleep(pause)
  }
  from
}

set.seed(4378888888)
simulate()

simulate()

  