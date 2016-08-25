# How does ddR handle global variables?

library(ddR)

globvar <- 100
f <- function(x) globvar

useBackend(parallel, type="FORK")

# Works fine
dl <- dlist(1:10, letters)
collect(dlapply(dl, f))


useBackend(parallel, type="PSOCK")

# Fails to find globvar
dl <- dlist(1:10, letters)
collect(dlapply(dl, f))
