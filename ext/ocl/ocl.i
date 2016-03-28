%module "viennacl::ocl"

%{
#include "viennacl/context.hpp"
%}

namespace viennacl {
  namespace ocl {

    %rename(Context) context;
    class context {
    public:
      context();
      ~context();
    };

    %rename(Device) device;
    class device {
    public:
      device();
      ~device();
    };

    const viennacl::ocl::context& viennacl::ocl::current_context();

  }
};
