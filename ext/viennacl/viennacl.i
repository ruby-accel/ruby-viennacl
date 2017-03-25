%module viennacl

%include std_vector.i
%template(StdVecDouble) std::vector<double>;
%template(StdVecVecDouble) std::vector<std::vector<double> >;
%template(StdVecFloat) std::vector<float>;
%template(StdVecVecFloat) std::vector<std::vector<float> >;

%{

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

  namespace backend {
    void finish();
  };

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
  } catch (const std::exception &e) {
    SWIG_exception(SWIG_RuntimeError, e.what());
  }
}

