require 'mkmf'
have_library("c++") or have_library("stdc++")

rubyviennacl_path = File.join(File.dirname(File.expand_path(__FILE__)), "../viennacl")
viennacl_path = File.join(File.dirname(File.expand_path(__FILE__)), "../viennacl/viennacl")
ruby_eigen_path = File.join(File.dirname(File.expand_path(__FILE__)), "ruby-eigen/ext/eigen/eigen3")
$CXXFLAGS = ($CXXFLAGS || "") + " -O2 -Wall -I #{rubyviennacl_path} -I #{viennacl_path} -I #{ruby_eigen_path} "
create_makefile('viennacl/eigen')
