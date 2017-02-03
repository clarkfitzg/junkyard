// n is the length of x, y
void bootbeta(float *x
        , float *y
        , float *betas
		, int n
        )
{
    // TODO: Do we call srand() ?
    int iboot;
    float sumx = 0.0;
    float sumy = 0.0;
    float sumx2 = 0.0;
    float sumxy = 0.0;
    for(int i = 0; i < n; i++)
    {
        iboot = rand() % n;
        sumx += x[iboot];
        sumy += y[iboot];
        sumx2 += x[iboot] * x[iboot];
        sumxy += x[iboot] * y[iboot];
    }
    float nd = (float) n;
    float xbar = sumx / nd;
    float ybar = sumy / nd;
    float x2bar = sumx2 / nd;
    float xybar = sumxy / nd;

    float b1 = (xybar - xbar * ybar) / (x2bar - xbar * xbar);
    float b0 = ybar - b1 * xbar;

    int id = get_global_id(0);

    betas[2 * id] = b0;
    betas[2 * id + 1] = b1;
}
