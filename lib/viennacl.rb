require "viennacl/viennacl"
require "viennacl/ocl"

ViennaCL = Viennacl
Object.send(:remove_const, "Viennacl")
