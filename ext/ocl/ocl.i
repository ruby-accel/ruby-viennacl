%module "viennacl::ocl"

%{
#include "viennacl/vector.hpp"
%}

namespace viennacl {
  namespace ocl {
    viennacl::ocl::device const & current_device();
  }
};
