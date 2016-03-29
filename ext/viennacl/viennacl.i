%module viennacl

%include std_vector.i
%template(StdVecDouble) std::vector<double>;
%template(StdVecVecDouble) std::vector<std::vector<double> >;
%template(StdVecFloat) std::vector<float>;
%template(StdVecVecFloat) std::vector<std::vector<float> >;

%import "ruby-eigen/ext/eigen/rubyeigen_base.h"

%inline %{
namespace Eigen {};
namespace RubyEigen {
  using namespace Eigen;
};
%}

%{

#define EIGEN_MPL2_ONLY
#include <Eigen/Core>
#include <Eigen/SparseCore>
#include <stdexcept>
#include "ruby-eigen/ext/eigen/rubyeigen_base.h"
#include "ruby-eigen/ext/eigen/rubyeigen_except.h"
#define VIENNACL_WITH_EIGEN 1

template<typename T>
struct Eigen_dense_matrix
{
  typedef typename T::ERROR_NO_EIGEN_TYPE_AVAILABLE   error_type;
};
template<>
struct Eigen_dense_matrix<float>
{
  typedef RubyEigen::MatrixFloat  type;
};
template<>
struct Eigen_dense_matrix<double>
{
  typedef RubyEigen::MatrixDouble  type;
};
typedef Eigen_dense_matrix<float>::type EigenMatrixf;
typedef Eigen_dense_matrix<double>::type EigenMatrixd;

#include <cstdint>
#include <cmath>
#include "viennacl/vector.hpp"
#include "viennacl/linalg/inner_prod.hpp"
#include "viennacl/linalg/norm_1.hpp"
#include "viennacl/linalg/norm_2.hpp"
#include "viennacl/linalg/norm_inf.hpp"
#include "viennacl/matrix.hpp"
#include "viennacl/linalg/matrix_operations.hpp"
#include "viennacl/linalg/prod.hpp"
#include "viennacl/linalg/direct_solve.hpp"
#include "viennacl/linalg/bicgstab.hpp"
#include "viennacl/linalg/cg.hpp"
#include "viennacl/linalg/mixed_precision_cg.hpp"
#include "viennacl/linalg/gmres.hpp"
#include "viennacl/linalg/ichol.hpp"
#include "viennacl/linalg/ilu.hpp"

#include "viennacl/coordinate_matrix.hpp"

#include "vector.hpp"

#include "rubyviennacl_base.hpp"

%}

%include "vector.i"
%include "matrix.i"
%include "solver.i"

namespace RubyViennacl {

  template<class LHS,class RHS, OP >
  class matrix_expression{
  public:
    matrix_expression(LHS&, RHS&);
    ~matrix_expression();
  };

  %template(ExpTransMatrixDouble) matrix_expression< const RubyViennacl::matrix_base<double>,
                                                     const RubyViennacl::matrix_base<double>,
                                                     RubyViennacl::op_trans >;
  %template(ExpTransMatrixFloat) matrix_expression< const RubyViennacl::matrix_base<float>,
                                                    const RubyViennacl::matrix_base<float>,
                                                    RubyViennacl::op_trans >;
  %template(ExpTransSpMatrixDouble) matrix_expression< const RubyViennacl::compressed_matrix<double>,
                                                     const RubyViennacl::compressed_matrix<double>,
                                                     RubyViennacl::op_trans >;
};

%exception {
  try {
    $action
  }
  catch (const RubyEigen::EigenRuntimeError &e) {
    /* this rb_raise is called inside SWIG functions. That's ok. */
    SWIG_exception(SWIG_RuntimeError, e.what());
  }
  catch (const std::exception &e) {
    SWIG_exception(SWIG_RuntimeError, e.what());
  }
}


namespace RubyViennacl {
  %newobject from_eigen;
};

%inline %{
  namespace RubyViennacl {
    const RubyViennacl::matrix<double>* from_eigen(const RubyEigen::MatrixDouble& e){
      RubyViennacl::matrix<double> *v = new RubyViennacl::matrix<double>(e.rows(), e.cols());
      const EigenMatrixd m(e);
      viennacl::copy(m, *v);
      return v;
    }
    const RubyViennacl::matrix<float>* from_eigen(const RubyEigen::MatrixFloat& e){
      RubyViennacl::matrix<float> *v = new RubyViennacl::matrix<float> (e.rows(), e.cols());
      const EigenMatrixf m(e);
      viennacl::copy(m, *v);
      return v;
    }

    const RubyViennacl::compressed_matrix<double>* from_eigen(const RubyEigen::SparseMatrix<double>& e){
      RubyViennacl::compressed_matrix<double> *ret = new RubyViennacl::compressed_matrix<double>(e.rows(), e.cols());
      RubyEigen::SparseMatrix<double, RubyEigen::RowMajor> e1(e);
      viennacl::copy(e1, *ret);
      return ret;
    }

    const RubyViennacl::compressed_matrix<float>* from_eigen(const RubyEigen::SparseMatrix<float>& e){
      RubyViennacl::compressed_matrix<float> *ret = new RubyViennacl::compressed_matrix<float>(e.rows(), e.cols());
      RubyEigen::SparseMatrix<float, RubyEigen::RowMajor> e1(e);
      viennacl::copy(e1, *ret);
      return ret;
    }

  };
%}
