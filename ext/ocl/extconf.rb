require 'mkmf'
have_library("c++") or have_library("stdc++")
dir_config("OpenCL")
find_header("viennacl/version.hpp", File.join(File.dirname(File.expand_path(__FILE__)), "../viennacl/viennacl/"))

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

$CXXFLAGS = ($CXXFLAGS || "") + " #{backend_flag} "
create_makefile('viennacl/OCL')
