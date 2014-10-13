# From Sen's Regression Analysis

df = data.frame(res = c(4041,   2200,   30148,  60324,  65468,  30988),
              mains = c(1332,   690,    11476,  18368,  22044,  10686))

mod1 = lm(sqrt(mains) ~ sqrt(res), df)


testmodel = function(mod, degfree=4, confidence=90){
    results = as.data.frame(coef(summary(mod)))

    # 90 percent confidence with 4 degrees freedom
    alpha = (1 - confidence / 100) / 2
    tscale = qt(1 - alpha, df=degfree)

    confidence = data.frame(
        lower= results[, 'Estimate'] - tscale * results[, 'Std. Error'],
        upper= results[, 'Estimate'] + tscale * results[, 'Std. Error']
    )

    return(confidence)
}

testmodel(mod1)

mod2 = lm(sqrt(mains) ~ sqrt(res) + 0, df)

testmodel(mod2, degfree=5)
