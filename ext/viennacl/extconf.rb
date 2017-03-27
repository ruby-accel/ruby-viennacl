require "mkmf"
have_library("c++") or have_library("stdc++")
dir_config("OpenCL")

gems = Gem::Specification.find_all_by_name("numo-narray")
if gems.size > 1
  raise "multiple numo-narray gems found"
end
find_header("numo/narray.h", File.join(gems[0].gem_dir, "lib/numo/") )
find_header("viennacl/version.hpp", File.join(File.dirname(File.expand_path(__FILE__)), "viennacl/"))
have_func("rb_gc_adjust_memory_usage")

backend_flag = ""

if enable_config("cuda")
  require "mkmf-cu"
  backend_flag += " -DVIENNACL_WITH_CUDA -x cu "
elsif enable_config("opencl") and (have_library("OpenCL") or have_framework("OpenCL"))
  backend_flag += " -DVIENNACL_WITH_OPENCL "
end

if enable_config("openmp")
  have_library("gomp") or have_library("iomp")
  backend_flag += " -fopenmp -DVIENNACL_WITH_OPENMP "
end

$CXXFLAGS = ($CXXFLAGS || "") + " -std=c++11 #{backend_flag} "
create_makefile('viennacl/ViennaCL')
