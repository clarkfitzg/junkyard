# Mon Feb  6 15:21:31 PST 2017
#
# simplest things with R's graph package
library(graph)
library(Rgraphviz)

V <- LETTERS[1:4]
edL1 <- vector("list", length=4)
names(edL1) <- V
for(i in 1:4)
  edL1[[i]] <- list(edges=c(2,1,4,3)[i], weights=sqrt(i))
gR <- graphNEL(nodes=V, edgeL=edL1)
edL2 <- vector("list", length=4)
names(edL2) <- V
for(i in 1:4)
  edL2[[i]] <- list(edges=c(2,1,2,1)[i], weights=sqrt(i))
gR2 <- graphNEL(nodes=V, edgeL=edL2, edgemode="directed")
