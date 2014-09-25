# Verifying the central limit theorem

library(boot)

set.seed(84)

p <- 0.5
n_pts <- 100
n_reps <- 100
n_se <- 100

bernoulli <- function(n){
    # Draw n times from a bernoulli random variable
    rbinom(n, 1, c(1-p, p))
}

make_p_hats <- function(){
    replicate(n_reps, mean(bernoulli(n_pts)))
}

se_theory <- sqrt(p * (1-p) / n)

se_boot <- boot(make_p_hats(), function(x, index) sd(x[index]), n_se)
se_sim <- replicate(n_se, sd(make_p_hats()))

hist(se_sim)
plot(se_boot)
