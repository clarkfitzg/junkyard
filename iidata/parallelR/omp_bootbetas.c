# include <omp.h>
# include <stdlib.h>

/* Given vectors x, y
 * compute OLS estimators b0, b1 
 * minimizing y = b0 + b1x
 * Write these to *beta, a double of length 2
 */ 
void fit_ols(double *x, double *y, int *n, double *beta)
{
    double sumx = 0.0;
    double sumy = 0.0;
    double sumx2 = 0.0;
    double sumxy = 0.0;
    for(int i = 0; i < *n; i++)
    {
        sumx += x[i];
        sumy += y[i];
        sumx2 += x[i] * x[i];
        sumxy += x[i] * y[i];
    }
    double nd = (double) *n;
    double xbar = sumx / nd;
    double ybar = sumy / nd;
    double x2bar = sumx2 / nd;
    double xybar = sumxy / nd;
    beta[1] = (xybar - xbar * ybar) / (x2bar - xbar * xbar);
    beta[0] = ybar - beta[1] * xbar;
}


void omp_bootstrap(double *x, double *y, int *n, int *nboots, double *beta)
{
    int sample, nthreads;
    double *xboot, *yboot;

    nthreads = omp_get_num_threads();

    // Statically partition nboots


    // We'll use the same bootstrap arrays over and over
    xboot = (double *)malloc(*n * sizeof(double));
    yboot = (double *)malloc(*n * sizeof(double));

    for(int k = 0; k < *nboots; k++)
    {
        // Sample with replacement
        for(int i = 0; i < *n; i++)
        {
            sample = rand() % *n;
            xboot[i] = x[sample];
            yboot[i] = y[sample];
        }
        // Fit OLS and write one column in beta
        fit_ols(xboot, yboot, n, beta + 2*k);
    }

    free(xboot);
    free(yboot);
}
