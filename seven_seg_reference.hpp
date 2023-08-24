#ifndef MATEXP_REFERENCE_INCLUDED
#define MATEXP_REFERENCE_INCLUDED
#include <cstdlib>
#include "archlab.h"
#include <unistd.h>
#include<cstdint>
#include"function_map.hpp"
#include <bits/stdc++.h>
using namespace std;

void __attribute__((optimize("O4"))) seven_segConversion(char *r, int32_t n)
{
    // Base Case
    r[0]=0x0;
    if (n == 0) {
        return;
    }
    if (n < 0) {
        r[0]=0x1;
        n = (-1)*n;
    }
 
    // To store the reverse of n
 
    // Reversing the digits
    int pos=10;
    while (n > 0) {
        switch (n % 10)
        {
            case 1: 
                r[pos]= 0x30;
                break;
            case 2:
                r[pos]= 0x6D;
                break;
            case 3:
                r[pos]= 0x79;
                break;
            case 4:
                r[pos]= 0x33;
                break;
            case 5:
                r[pos]= 0x5B;
                break;
            case 6:
                r[pos]= 0x5F;
                break;
            case 7:
                r[pos]= 0x70;
                break;
            case 8:
                r[pos]= 0x7F;
                break;
            case 9:
                r[pos]= 0x73;
                break;
            default: 
                r[pos]= 0x7e; 
        }
        n /= 10;
        pos--;
    }
    while (pos>0) 
        r[pos--] = 0x0;
 
    // Iterate through all digits in rev
}


//template<typename T>
void __attribute__((noinline,optimize("O4"))) seven_seg_reference(char **dst, int32_t *src, uint32_t size) {
    // Base Case
    for(int i = 0; i < size; i++)
    {
#ifdef DEBUG_MESSAGE
        std::cerr << "input:" << src[i] << std::endl;
#endif
        seven_segConversion(dst[i], src[i]);
#ifdef DEBUG_MESSAGE
        std::cerr << "ref:" << dst[i] << std::endl;
#endif
    }
}
#endif