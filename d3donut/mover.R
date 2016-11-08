onerow = function(index, total = 50){
    x = rep(0, total)
    a = (index-1) %% total
    b = (index+1) %% total

    x[a] = 0.5
    x[index] = 1
    x[b] = 0.5
    x
}

mover = data.frame(sapply(1:50, onerow))

write.table(mover, "mover.csv", sep = ","
            , col.names = FALSE, row.names = FALSE)
