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
    struct viennacl::ocl::gpu_tag GPUTag = viennacl::ocl::gpu_tag();
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

      const std::string cache_path();
      void cache_path(const std::string);
      const std::vector<viennacl::ocl::device>& devices();
      const viennacl::ocl::device current_device();
      void switch_device(const viennacl::ocl::device&);

      void add_queue(const viennacl::ocl::device);
      const viennacl::ocl::command_queue& get_queue();
      const viennacl::ocl::command_queue& current_queue();
      void switch_queue(size_t);

      const std::string build_options();
      void build_options(const std::string);

      void init();

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

      cl_device_id id();
      const std::string info();
    };

    %rename(Platform) platform;
    class platform {
    public:
      platform();
      ~platform();
      const std::vector<viennacl::ocl::device> devices();
      cl_platform_id id();
    };

    %rename(CommandQueue) command_queue;
    class command_queue {
    public:
      command_queue();
      ~command_queue();
    };

    %rename(Program) program;
    class program {
    public:
      program();
      ~program();
    };

    const viennacl::ocl::context& viennacl::ocl::current_context();
    void set_context_device_type(long, viennacl::ocl::cpu_tag);
  };
};
