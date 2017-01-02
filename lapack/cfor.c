#include <stdio.h>
#include <math.h>

#define size 3                          /* dimension of matrix */

struct complex {double re; double im;};         /* a complex number */

main()
{
struct complex A[3][3], b[3], WORK[6], RWORK[6];

struct complex w[3], vl[1][3], vr[1][3];

double AT[2*size*size];                 /* for transformed matrix */
int i, j, ok;
char jobvl, jobvr;
int n, lda, ldvl, ldvr, lwork;

n=size;
jobvl='N';
jobvr='N';
lda=size;
ldvl=1;
ldvr=1;
lwork=6;

A[0][0].re=3.1;A[0][0].im=-1.8;         /* the input matrix */
A[0][1].re=1.3;A[0][1].im=0.2;
A[0][2].re=-5.7;A[0][2].im=-4.3;
A[1][0].re=1.0;A[1][0].im=0;
A[1][1].re=-6.9;A[1][1].im=3.2;
A[1][2].re=5.8;A[1][2].im=2.2;
A[2][0].re=3.4;A[2][0].im=-4;
A[2][1].re=7.2;A[2][1].im=2.9;
A[2][2].re=-8.8;A[2][2].im=3.2;

for (i=0; i<size; i++)          /* to call a Fortran routine from C we */
{                               /* have to transform the matrix */
  for(j=0; j<size; j++)
  {
     AT[2*(j+size*i)]=A[j][i].re;
     AT[2*(j+size*i)+1]=A[j][i].im;
  }
}

/* find solution using LAPACK routine ZGEEV, all the non-array arguments
have to be pointers */
zgeev(&jobvl, &jobvr,&n, AT, &lda, w, vl, &ldvl, vr, &ldvr, WORK, &lwork, 
RWORK, &ok);

if (ok==0)                              /* output of eigenvalues */
{
   for (i=0; i<size; i++)
   {
      printf("%f\t%f\n", w[i].re, w[i].im);
   }
}
else printf("An error occurred");

return(1);
}
