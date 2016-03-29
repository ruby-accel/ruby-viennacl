require "rake/extensiontask"
require 'rake/testtask'
require 'rake/clean'

vlibs = ["ViennaCL"]
other_libs = ["OCL"]
elibs = vlibs + other_libs

elibs.each{|s|
  Rake::ExtensionTask.new s do |ext|
    ext.ext_dir = "ext/#{s.downcase}"
    ext.lib_dir = "lib/viennacl"
    ext.source_pattern = "{*/*,*}.{cxx,i,hpp,h,inc}"
  end
}

file "ext/viennacl/viennacl_wrap.cxx" => Dir.glob("ext/viennacl/*.{i,hpp}") do
  sh "swig -c++ -ruby -Wall -module ViennaCL ext/viennacl/viennacl.i"
end

file "ext/ocl/ocl_wrap.inc" => Dir.glob("ext/ocl/*.{i,hpp}") do
  sh "swig -c++ -ruby -Wall -module 'ViennaCL::OCL' -o ext/ocl/ocl_wrap.inc ext/ocl/ocl.i"
end

namespace :swg do
  task "viennacl" do
    sh "swig -c++ -ruby -Wall -module ViennaCL ext/viennacl/viennacl.i"
  end

  task "ocl" do
    sh "swig -c++ -ruby -Wall -module 'ViennaCL::OCL' -o ext/ocl/ocl_wrap.inc ext/ocl/ocl.i"
  end
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end
desc "Run tests"

task :swig => ["ext/viennacl/viennacl_wrap.cxx", "ext/ocl/ocl_wrap.inc"]
task :default => [:test]
task :build => ["swg:viennacl", "swg:ocl", :compile]
