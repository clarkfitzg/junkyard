# A very simple parallel program

library(parallel)


# An idiomatic R way to write this:
count_votes = function(prob_trump = 0.5, n = 1e7)
{
    probs = c(prob_trump, 1 - prob_trump)
    votes = sample(c("trump", "clinton"), size = n
                   , replace = TRUE, prob = probs)
    table(votes)
}


# A function to parallelize.
# Typically each one will take a while to run
count_votes_slowly = function(n = 1e7, prob_trump = 0.5)
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

probs = seq(0.4, 0.6, length.out = 20)

results = mclapply(probs, count_votes, n = 1000)
