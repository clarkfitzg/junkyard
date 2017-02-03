//#include "cl/mwc64x.cl"


// Grabbing from here:
// http://stackoverflow.com/questions/7602919/how-do-i-generate-random-numbers-without-rand-function


//TODO: Doesn't work here yet
/*
unsigned short lfsr = 0xACE1u;

unsigned short rand()
{
  unsigned short bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ) & 1;
  return lfsr = (lfsr >> 1) | (bit << 15);
}
*/



// n is the length of x, y
__kernel void bootbeta(__global const float *x
        , __global const float *y
        , __global float *betas
		, int n
        )
{
    //mwc64x_state_t random_state;

    //uint r;
    int iboot;
    float sumx = 0.0;
    float sumy = 0.0;
    float sumx2 = 0.0;
    float sumxy = 0.0;

    unsigned short r = 0xACE1u;

    for(int i = 0; i < n; i++)
    {
        // No rand in OpenCL!
        //iboot = (int) rand() % n;
        //r = MWC64X_NextUint(*random_state);
        iboot = (int) r;
        //iboot = i;

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
