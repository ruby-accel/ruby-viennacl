require "viennacl/ViennaCL"
require "viennacl/OCL"
require "accel/gcthread"

Accel::GCThread.setup(lambda{true}, lambda{})
