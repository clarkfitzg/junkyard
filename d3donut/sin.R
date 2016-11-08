sin_row = function(phase = 0){
    x = seq(0, 2*pi, length.out = 50)
    (1 + sin(x - phase)) / 2
}

out = sapply(seq(0, 50, length.out = 500), sin_row)
out = data.frame(t(out))

write.table(out, "sin.csv", sep = ","
            , col.names = FALSE, row.names = FALSE)
