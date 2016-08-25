# Understanding R environments and the behavior of serialization

rawlength <- function(x) length(serialize(x, connection = NULL))

a <- 1
b <- 2
f <- function(x) x + a + b

rawlength(f) # 440

# The global environment
e <- environment(f)

enew <- new.env()
enew$a <- 10

environment(f) <- enew
rawlength(f) # 604

f(4) # 10 + 2 + 4 = 16

p <- new.env()
p$a <- 10000
p$b <- 4
parent.env(enew) <- p
rawlength(f) # 792

rawlength(p) # 224

f(4) # 10 + 4 + 4 = 18

