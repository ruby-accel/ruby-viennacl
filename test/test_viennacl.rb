require "test/unit"
require "viennacl"
require "matrix"
class TestViennaCL < Test::Unit::TestCase
  def test_s
    n = 3
    v = [1,2,3]
    m0 = [v]*n
    m = ViennaCL::MatrixFloat::create(m0)
    assert_equal(6, (m * m)[0,0])
    assert_equal(18, (m * m)[2,2])
    v = ViennaCL::VectorFloat::create([3,2,1])
    assert_equal(10, (m * v)[0])

    v0 = [1,2,3,4]
    m0 = [v0]*2
    m = ViennaCL::MatrixFloat::create(m0)
    v = ViennaCL::VectorFloat::create([1,1,1,1])
    assert_equal([10,10], (m*v).to_a)
  end

  def test_eigen
    begin
      require "eigen"
      m = Eigen::MatrixFloat[[1,2],[3,4]]
      m2 =ViennaCL.from_eigen(m)
      assert_equal([[1,2],[3,4]],
                   m2.to_a)
      assert_equal(m, m2.to_eigen)
    rescue LoadError
    end
  end

  def test_ocl
    c = ViennaCL::OCL.current_context()
    c.current_device().info()
    ViennaCL::OCL.set_context_device_type(0, ViennaCL::OCL.CPUTag)
    c.current_device().info()
    ViennaCL::OCL::Platform.new.devices()
  end

  def test_sp_eigen
    begin
      require "eigen"
      m = Eigen::SpMatrixFloat.new(2,2)
      m[0,0] = 1
      m[0,1] = 2
      m1 = ViennaCL.from_eigen(m)
      assert_equal(m[0,0], m1[0,0])
      assert_equal(m[0,1], m1[0,1])
    rescue LoadError
    end
  end

end
