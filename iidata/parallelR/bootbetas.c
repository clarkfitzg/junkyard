/* Given vectors x, y
 * compute OLS estimators b0, b1 
 * minimizing y = b0 + b1x
 * Write these to *beta
 */ 
void fit_ols(double *x, double *y, int *n, double *beta)
{
    double sumx = 0;
    double sumy = 0;
    double sumx2 = 0;
    double sumxy = 0;
    int i;
    for(i = 0; i < n[0]; i++)
    {
        sumx += x[i];
        sumy += y[i];
        sumx2 += x[i] * x[i];
        sumxy += x[i] * y[i];
    }
    double nd;
    nd = (double) n[0];
    double xbar = sumx / nd;
    double ybar = sumy / nd;
    double x2bar = sumx2 / nd;
    double xybar = sumxy / nd;
    beta[1] = (xybar - xbar * ybar) / (x2bar - xbar * xbar);
    beta[0] = ybar - beta[1] * xbar;
}
