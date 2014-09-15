library('boot')

set.seed(21)

mean_index <- function(x, index){
    mean(x[index])
}

inside <- function(sampsize=100){
# Returns true if population mean is inside two sd of bootstrap 
# confidence interval

    normdata <- rnorm(sampsize)
    b <- boot(normdata, mean_index, R=100)

    two_sd <- 2 * sd(b$t)

    # Simple 2 standard deviation confidence interval
    low <- b$t0 - two_sd
    high <- b$t0 + two_sd

    return(low < 0 & 0 < high)
}


# Experiment to see how many times this confidence interval contains
# the true value of t0 = 0.

actual_inside <- replicate(1000, inside())
print(sum(actual_inside))

# Prints 951 - Very close to 95% confidence interval. Cool.
