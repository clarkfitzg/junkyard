library(nnet)

n = 100
d = data.frame(x = seq(0, 10, length.out = n))
#d$x2 = rnorm(n)
d$y = sin(d$x)
#d$noisey = d$y + 0.1*rnorm(n)

# This neural net fit isn't piecewise linear.
# It also tends to look different every time I run it :)
# Maybe that's what it means for it to be caught in a local minima, those
# cases when it flattens out.
fit = nnet(y ~ x, d, size = 2, linout = TRUE, skip = FALSE)
d$preds = predict(fit)
with(d, {
     plot(x, y)
     lines(x, preds, lty = 1, lwd = 3)
})


# Let's try the one in another package

library(h2o)

h2o.init()

d2 = as.h2o(d)


# This would be a great piece for some data art.

fit2 = h2o.deeplearning(x = 1, y = 2, d2
                        , activation = "Rectifier"
                        , hidden = c(50, 50)
                        , score_each_iteration = TRUE
                        , adaptive_rate = FALSE
                        #, momentum_start = 0.5
                        )

p = as.data.frame(predict(fit2, d2))[, 1]
plot(d$x, d$y)
lines(d$x, p, lwd = 2)

# Why do these predictions perform so poorly? I'm not asking for any
# regularization.
