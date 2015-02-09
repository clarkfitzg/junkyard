Looking at the contrast matrix for balanced design.

To prepare we'll prepare some data that satisfies the ANOVA model assumptions.


```r
set.seed(893)

x = rep(1:3, each=4)
y = 5 * x + rnorm(length(x))

d = data.frame(x = as.factor(x), y = y)
plot(d)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png) 

Here are the default treatment contrasts (aka dummy coding).


```r
fit1 = aov(y ~ x, d)
coef(fit1)
```

```
## (Intercept)          x2          x3 
##    3.705732    6.296603   10.927874
```

```r
model.matrix(fit1)
```

```
##    (Intercept) x2 x3
## 1            1  0  0
## 2            1  0  0
## 3            1  0  0
## 4            1  0  0
## 5            1  1  0
## 6            1  1  0
## 7            1  1  0
## 8            1  1  0
## 9            1  0  1
## 10           1  0  1
## 11           1  0  1
## 12           1  0  1
## attr(,"assign")
## [1] 0 1 1
## attr(,"contrasts")
## attr(,"contrasts")$x
## [1] "contr.treatment"
```

We can specify contrasts for each factor inside the call to lm or aov.


```r
fit2 = aov(y ~ x, d, contrasts=list(x=contr.sum))
coef(fit2)
```

```
## (Intercept)          x1          x2 
##   9.4472245  -5.7414922   0.5551108
```

```r
model.matrix(fit2)
```

```
##    (Intercept) x1 x2
## 1            1  1  0
## 2            1  1  0
## 3            1  1  0
## 4            1  1  0
## 5            1  0  1
## 6            1  0  1
## 7            1  0  1
## 8            1  0  1
## 9            1 -1 -1
## 10           1 -1 -1
## 11           1 -1 -1
## 12           1 -1 -1
## attr(,"assign")
## [1] 0 1 1
## attr(,"contrasts")
## attr(,"contrasts")$x
##   [,1] [,2]
## 1    1    0
## 2    0    1
## 3   -1   -1
```

We can also change the default.


```r
options(contrasts=c('contr.sum', 'contr.sum'))

fit3 = aov(y ~ x, d)
coef(fit3)
```

```
## (Intercept)          x1          x2 
##   9.4472245  -5.7414922   0.5551108
```

Lets check how predict works.


```r
dnew = data.frame(x = unique(d$x))

predict(fit1, dnew)
```

```
##         1         2         3 
##  3.705732 10.002335 14.633606
```

```r
predict(fit2, dnew)
```

```
##         1         2         3 
##  3.705732 10.002335 14.633606
```

Same for both.
