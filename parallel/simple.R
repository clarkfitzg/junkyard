# A very simple parallel program
#
# We specify the probability that each individual
# votes for a candidate, and then simulate the counts
# for n such voters. 
#
# count_votes and count_votes_slow are the functions
# to parallelize. Typically each run will take some
# time to complete.
#
# CAVEAT: This is useful for understanding
# the parallel package. Realistic voter simulations
# should be more sophisticated than this!

library(parallel)


# An idiomatic, vectorized R way to write this:
count_votes = function(prob_trump = 0.5, n = 1e6)
{
    probs = c(prob_trump, 1 - prob_trump)
    votes = sample(c("trump", "clinton"), size = n
                   , replace = TRUE, prob = probs)
    table(votes)
}


# This is inefficient in R.
# Hence the function name :)
count_votes_slow = function(prob_trump = 0.5, n = 1e6)
{
    probs = c(prob_trump, 1 - prob_trump)
    counts = c(trump = 0, clinton = 0)
    for( i in seq(n) )
    {
        vote = sample(c("trump", "clinton"), size = 1
                      , prob = probs)
        if( vote == "trump")
        {
            counts["trump"] = counts["trump"] + 1
        } else
        {
            counts["clinton"] = counts["clinton"] + 1
        }
    }
    counts
}

# Arguments to apply over
probs = c(florida = 0.507
        , colorado = 0.484
        , pennsylvania = 0.506
        , michigan = 0.501
        , virginia = 0.475
        , arizona = 0.522
        , nevada = 0.487
        , wisconsin = 0.505
        )

# set.seed() sets the random number generator, making 
# simulations reproducible.

# Base R
set.seed(37, kind = "default")
results = lapply(probs, count_votes_slow, n = 5e6)

# Try playing around with n, mc.cores and watching
# CPU resource usage as you run this one:
set.seed(37, kind = "L'Ecuyer")
results2 = mclapply(probs, count_votes_slow
                    , mc.cores = 8, n = 5e6)
