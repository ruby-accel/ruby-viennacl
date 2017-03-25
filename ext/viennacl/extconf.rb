require 'mkmf'
have_library("c++") or have_library("stdc++")

gems = Gem::Specification.find_all_by_name("numo-narray")
if gems.size > 1
  raise "multiple numo-narray gems found"
end
find_header("numo/narray.h", File.join(gems[0].gem_dir, "lib/numo/") )

have_func("rb_gc_adjust_memory_usage")

device_flag = ""
if arg_config("--enable-cuda") and defined?(MKMF_CU)
  device_flag = " -DVIENNACL_WITH_CUDA -x cu "
elsif arg_config("--enable-opencl") and (have_library("OpenCL") or have_framework("OpenCL"))
  device_flag = " -DVIENNACL_WITH_OPENCL "
end
if arg_config("--enable-openmp")
  device_flag += " -fopenmp -DVIENNACL_WITH_OPENMP "
end

viennacl_path = File.join(File.dirname(File.expand_path(__FILE__)), "viennacl/")

$CXXFLAGS = ($CXXFLAGS || "") + " -O2 -I #{viennacl_path} #{device_flag} "
create_makefile('viennacl/ViennaCL')
