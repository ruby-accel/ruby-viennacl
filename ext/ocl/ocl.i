%module "viennacl::ocl"

%include std_string.i
%include std_vector.i

%{
#include "viennacl/context.hpp"
%}

%inline %{
namespace viennacl {
  namespace ocl {
    struct viennacl::ocl::cpu_tag CPUTag = viennacl::ocl::cpu_tag();
  };
};
%}

%template(StdVectorDevice) std::vector<viennacl::ocl::device>;

namespace viennacl {
  namespace ocl {

    %rename(Context) context;
    class context {
    public:
      context();
      ~context();
      const viennacl::ocl::device current_device();
    };

    %rename(Device) device;
    class device {
    public:
      device();
      ~device();

      bool available();
      const std::string extensions();

      unsigned long global_mem_cache_size();
      unsigned long global_mem_size();

      const std::string vendor();
      const std::string driver_version();
      bool double_support();

      const std::string info();
    };

    %rename(Platform) platform;
    class platform {
    public:
      platform();
      ~platform();
      std::vector<viennacl::ocl::device> devices();
    };

    const viennacl::ocl::context& viennacl::ocl::current_context();
    void set_context_device_type(long, viennacl::ocl::cpu_tag);
  };
};

namespace viennacl {
  namespace ocl {
    //%constant    cpu_tag CPUTag = new viennacl::ocl::cpu_tag();
  };
};
