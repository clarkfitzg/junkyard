#include <Rcpp.h>
#include <hello.cpp>

// [[Rcpp::export]]
int times2(int x) {
    return 2 * x;
}

// Following is specific to Rcpp
RCPP_MODULE(hello) {
    using namespace Rcpp;
    function("hello" , &hello);
}
