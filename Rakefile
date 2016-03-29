require "rake/extensiontask"
require 'rake/testtask'
require 'rake/clean'

vlibs = ["ViennaCL"]
other_libs = ["OCL"]
elibs = vlibs + other_libs

pat = "{*/*,*}.{cxx,i,hpp,h,inc}"
swig_pat = "{*/*,*}.{i,hpp,h}"

elibs.each{|s|
  Rake::ExtensionTask.new s do |ext|
    ext.ext_dir = "ext/#{s.downcase}"
    ext.lib_dir = "lib/viennacl"
    ext.source_pattern = pat
  end
}

task :viennacl => ["ext/viennacl/viennacl_wrap.cxx"]
file "ext/viennacl/viennacl_wrap.cxx" => Dir.glob("ext/viennacl/#{swig_pat}") do
  Rake::Task["swg:viennacl"].execute
end

task :ocl => ["ext/ocl/ocl_wrap.inc"]
file "ext/ocl/ocl_wrap.inc" => Dir.glob("ext/ocl/#{swig_pat}") do
   Rake::Task["swg:ocl"].execute
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

task :swig => [:viennacl, :ocl]
task :default => [:test]
task :build => ["swg:viennacl", "swg:ocl", :compile]
