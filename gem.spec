Gem::Specification.new do |s|
  s.name        = 'ruby-viennacl'
  s.version     = '0.2.0.pre1'
  s.date        = '2017-03-27'
  s.summary     = "Ruby binding for ViennaCL"
  s.description = "Ruby binding for ViennaCL, free open-source GPU-accelerated linear algebra and solver library."
  s.authors     = ["Takashi Tamura"]
  s.email       = ''
  s.files       = ["LICENSE", 
#                   "README.md",
                   "lib/viennacl.rb",
                   "ext/ocl/ocl.cxx",
                   "ext/ocl/ocl_wrap.inc",
                   "ext/viennacl/ops.hpp",
                   "ext/viennacl/rubyviennacl_base.hpp",
                   "ext/viennacl/viennacl_wrap.cxx"] + Dir.glob("ext/viennacl/viennacl/viennacl/**/*")
  s.extensions  = ["ext/viennacl/extconf.rb", "ext/ocl/extconf.rb"]
  s.homepage    = 'https://github.com/ruby-accel/ruby-viennacl'
  s.license     = 'MIT'
  s.add_runtime_dependency 'rake-compiler', '~> 0.9.5'
  s.rdoc_options << "--exclude=."
  s.required_ruby_version = '>= 2.2.0'
end
