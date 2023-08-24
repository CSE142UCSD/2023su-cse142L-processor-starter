#include"seven_seg_reference.hpp"
#include"seven_seg_solution.hpp"


extern "C"
void seven_seg_reference_c(char **dst, int32_t *src,
			uint32_t size)
{
	//for(int i = 0; i < ITERATIONS; i++) {
		seven_seg_reference(dst, src, size);
	//}
}
FUNCTION(seven_seg, seven_seg_reference_c);


extern "C"
void seven_seg_solution_c(char **dst, int32_t *src,
			uint32_t size)
{
	//for(int i = 0; i < ITERATIONS; i++) {
		seven_seg_solution(dst, src, size);
	//}
}
FUNCTION(seven_seg, seven_seg_solution_c);
