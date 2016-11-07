sin_row = function(phase = 0){
    x = seq(0, 2*pi, length.out = 50)
    (1 + sin(x - phase)) / 2
}

out = sapply(seq(0, pi, length.out = 100), sin_row)
out = data.frame(t(out))

write.csv(out, "sin.csv", col.names = FALSE, row.names = FALSE)
