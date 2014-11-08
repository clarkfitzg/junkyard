# Functions which may come in handy later


anova.table = function(model){

    # Makes an ANOVA table for a model resulting from lm output

    a = anova(model)

    total = data.frame('SS' = sum(a[, 'Sum Sq']), 'DF' = sum(a$Df))
    error = data.frame('SS' = a['Residuals', 'Sum Sq'], 
                       'DF' = a['Residuals', 'Df'])
    regression = data.frame(total - error)

    out = rbind(regression, error, total)
    out$MS = out$SS / out$DF
    row.names(out) = c('regression', 'error', 'total')
    return(out)
}


plothelper = function(varname, plotfunc, data=property, ...){
    # Plots individual plots with the variable name
    # ... are additional arguments to `plotfunc`
    plotfunc(data[, varname], main = varname, ...)
}
varnames = names(property)
sapply(varnames, plothelper, boxplot)
sapply(varnames, plothelper, hist, xlab='')

