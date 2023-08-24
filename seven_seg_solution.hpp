#ifndef MATEXP_SOLUTION_INCLUDED
#define MATEXP_SOLUTION_INCLUDED
#include <cstdlib>
#include "archlab.h"
#include <stdio.h>
#include <unistd.h>
#include<cstdint>
#include <cassert>
#include"function_map.hpp"

//template<typename T>
void __attribute__((noinline,optimize("O4"))) seven_seg_solution(char **dst, int32_t *src, uint32_t size) {
    //uint32_t new_size = (size >> 2) << 2;
    int data_size = size >> 3;
    char temp[12]="";
    for(int i = 0; i < data_size << 3; i++)
    {
//        std::cerr << "input:" << src[i] << std::endl;
        seven_segConversion(dst[i], src[i]);
#ifdef DEBUG_MESSAGE
        std::cerr << "sol:" << dst[i] << std::endl;
#endif
    }

}

#endif
