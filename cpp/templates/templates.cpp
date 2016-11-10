/* What I've learned:
 * char *'s include a NULL character at the end, so the length is one more
 * than the number of characters.
 * sprintf is called for side effects of modifying char* in place, so it
 * didn't work when called inline with the << chain.
 */

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
    char *one_digit;
    int out = noisy_add(1, 2);
    //std::cout << std::to_string(noisy_add(1, 2));
    sprintf(one_digit, "%d", out);
    cout << one_digit << "\n";
    return 0;
}

