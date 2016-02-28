require "rake/extensiontask"
require 'rake/testtask'
require 'rake/clean'

vlibs = ["viennacl"]
olibs = ["ocl"]
elibs = vlibs + olibs
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
  olibs.each{|f|
    task f do
      sh "swig -c++ -ruby -Wall ext/#{f}/#{f}.i"
      sh "mv ext/#{f}/#{f}_wrap.cxx ext/#{f}/#{f}_wrap.inc"
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
