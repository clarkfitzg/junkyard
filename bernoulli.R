# Verifying the central limit theorem

library(boot)
    x = 10
set.seed(84)

n <- 100
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

#hist(se_sim)
#plot(se_boot)

# 90 percent confidence interval
percent <- 0.9
alpha <- 1 - percent
difference <- se_theory * qnorm(1 - alpha/2)
lower <- p - difference
upper <- p + difference
ratio_inside <- function(){
    # whats the ratio of p_hats landing inside the confidence interval?
    p_hats <- make_p_hats()
    sum(lower < p_hats & p_hats < upper) / length(p_hats)
}

# Stays pretty close to the expected 90 percent.
inside <- replicate(500, ratio_inside())
hist(inside)
