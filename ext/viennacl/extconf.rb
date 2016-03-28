require 'mkmf'
have_library("c++") or have_library("stdc++")

device_flag = ""
if defined?(MKMF_CU)
  device_flag = " -DVIENNACL_WITH_CUDA -x cu "
elsif have_library("OpenCL") or have_framework("OpenCL")
  device_flag = " -DVIENNACL_WITH_OPENCL "
end
viennacl_path = File.join(File.dirname(File.expand_path(__FILE__)), "viennacl/")
eigen_path = File.join(File.dirname(File.expand_path(__FILE__)), "ruby-eigen/ext/eigen/eigen3/")

$CXXFLAGS = ($CXXFLAGS || "") + " -O2 -I #{viennacl_path} #{device_flag} -I #{eigen_path} "
create_makefile('viennacl/viennacl')
