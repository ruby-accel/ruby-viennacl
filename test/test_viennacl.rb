require "test/unit"
require "viennacl"
require "matrix"
require "numo/narray"

class TestViennaCL < Test::Unit::TestCase
  def test_s
    n = 3
    v = [1,2,3]
    m0 = [v]*n
    m = ViennaCL::SFloatMatrix::create(m0)
    assert_equal(6, (m.dot m)[0,0])
    assert_equal(18, (m.dot m)[2,2])
    v = ViennaCL::SFloatVector::create([3,2,1])
    assert_equal(10, (m.dot v)[0])

    v0 = [1,2,3,4]
    m0 = [v0]*2
    m = ViennaCL::DFloatMatrix::create(m0)
    v = ViennaCL::DFloatVector::create([1,1,1,1])
    assert_equal([10,10], (m.dot v).to_a)
  end

  def test_ocl
    c = ViennaCL::OCL.current_context()
    c.current_device().info()
    ViennaCL::OCL.set_context_device_type(0, ViennaCL::OCL.CPUTag)
    c.current_device().info()
    ViennaCL::OCL::Platform.new.devices()
  end

  def test_from_narray
    assert_equal([1,2,3],
                 ViennaCL::SFloatVector.from_narray(Numo::SFloat[1,2,3]).to_a)
    assert_equal([1,2,3],
                 ViennaCL::DFloatVector.from_narray(Numo::DFloat[1,2,3]).to_a)

    ViennaCL::SFloatMatrix.from_narray(Numo::SFloat[[1,2],[3,4]]).to_a
  end
end
