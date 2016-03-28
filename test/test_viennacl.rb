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
      m = Eigen::MatrixDouble[[1,2],[3,4]]
      assert_equal([[1,2],[3,4]],
                   ViennaCL.__eigen_to_viennacl__(m).to_a)
    rescue LoadError
    end
  end

  def test_ocl
    p ViennaCL::OCL.current_context()
  end
end
