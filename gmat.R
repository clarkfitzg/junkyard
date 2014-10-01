gmat = read.csv('/Users/clark/data/gmat.csv')

names(gmat) = c('experience', 'days_prep', 'gpa', 'female', 'gmat')

mod = lm(gmat ~ ., gmat)

print(summary(mod))
