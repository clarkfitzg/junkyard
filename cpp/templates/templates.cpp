/* What I've learned:
 * char *'s include a NULL character at the end, so the length is one more
 * than the number of characters.
 * sprintf is called for side effects of modifying char* in place, so it
 * didn't work when called inline with the << chain.
 */

#include <stdio.h>
#include <iostream>

using namespace std;


int noisy_add_int(int a, int b)
{
    cout << "Inside noisy_add_int\n";
    return a + b;
}


template<typename T>
T noisy_add(T a, T b)
{
    cout << "Inside noisy_add\n";
    return a + b;
}


int main()
{
    char *one_digit;
    //int out = noisy_add_int(1, 2);
    int out = noisy_add(1.0, 2.2);

    sprintf(one_digit, "%d", out);
    cout << one_digit << "\n";
    return 0;
}

