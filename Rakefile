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
    ext.source_pattern = "*.c*"
  end
}

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

task :swig => elibs.map{|f| "swg:#{f.downcase}" }
task :default => [:test]
task :build => [:swig, :compile]

# rake compile:stl
