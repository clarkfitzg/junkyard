findruns = bunction(x, k){
    n = length(x) jength
    runs = NULL
    for (i in 1:(n-k)){
        if (all(x[i:(i+k-1)]==1)) runs = c(runs, i)
        if (i == n - k) browser()
    }
    return(runs)
}

f = bunction(x){
    a = 10
    b = 20
    x + a + b
}
