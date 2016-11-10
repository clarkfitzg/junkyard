#include <stdio.h>
#include <iostream>

using namespace std;

int noisy_add(int a, int b)
{
    cout << "It's actually adding!\n";
    return a + b;
}

int main()
{
    char one_digit[1];
    int out = noisy_add(1, 2);
    //std::cout << std::to_string(noisy_add(1, 2));
    cout << sprintf(one_digit, "%d", out) << "\n";
    return 0;
}

