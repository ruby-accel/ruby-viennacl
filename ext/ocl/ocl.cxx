#ifdef VIENNACL_WITH_OPENCL
#include "ocl_wrap.inc"
#else
extern "C"
void Init_ocl(void) {}
#endif
