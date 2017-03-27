require 'numo/narray'
require 'viennacl'
require 'benchmark'

include Numo
include ViennaCL
size = 1300

Benchmark.bmbm do |x|
  [["float", SFloat, SFloatMatrix], ["double", DFloat, DFloatMatrix]].each{|tag, na, cl|
    a = na.new(size, size).rand(1,10)
    b = na.new(size, size).rand(1,10)
    x.report("numo/narray #dot #{tag}") do
      c = a.dot b
    end

    a1 = cl.from_narray(a)
    b1 = cl.from_narray(b)
    x.report("viennacl    #dot #{tag}") do
      c = a1.dot b1
      ViennaCL.finish()
    end

    x.report("viennacl    copy #{tag}") do
      a1 = cl.from_narray(a)
      b1 = cl.from_narray(b)
    end
  }

size = 3000

  [["float", SFloat, SFloatMatrix], ["double", DFloat, DFloatMatrix], ["int32", Int32, Int32Matrix]].each{|tag, na, cl|
    a = na.new(size, size).rand(1,10)
    b = na.new(size, size).rand(1,10)
    x.report("numo/narray #+   #{tag}") do
      c = a + b
    end

    a1 = cl.from_narray(a)
    b1 = cl.from_narray(b)
    x.report("viennacl    #+   #{tag}") do
      c = a1 +b1
      ViennaCL.finish()
    end

    x.report("viennacl    copy #{tag}") do
      a1 = cl.from_narray(a)
      b1 = cl.from_narray(b)
    end
  }

end

