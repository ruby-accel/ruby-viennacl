require "rake/extensiontask"
require 'rake/testtask'
require 'rake/clean'

vlibs = ["viennacl"]
other_libs = ["ocl"]
elibs = vlibs + other_libs
elibs.each{|s|
  Rake::ExtensionTask.new s do |ext|
    ext.lib_dir = "lib/viennacl"
  end
}

namespace :swg do
  vlibs.each{|f|
    task f do
      sh "swig -c++ -ruby -Wall ext/#{f}/#{f}.i"
    end
  }
  other_libs.each{|f|
    task f do
      sh "swig -c++ -ruby -Wall -o ext/#{f}/#{f}_wrap.inc ext/#{f}/#{f}.i"
    end
  }
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end
desc "Run tests"

task :swig => elibs.map{|f| "swg:#{f}" }
task :default => [:test]
task :build => [:swig, :compile]

# rake compile:stl
