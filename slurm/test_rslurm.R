# Following:
# https://cran.r-project.org/web/packages/rslurm/vignettes/rslurm.html

library(rslurm)


test_func <- function(par_mu, par_sd) {
    samp <- rnorm(10^6, par_mu, par_sd)
    c(s_mu = mean(samp), s_sd = sd(samp))
}

pars <- data.frame(par_mu = 1:10,
                   par_sd = seq(0.1, 1, length.out = 10))


sjob <- slurm_apply(test_func, pars, jobname = 'test_apply',
                    nodes = 2, cpus_per_node = 2, submit = FALSE)