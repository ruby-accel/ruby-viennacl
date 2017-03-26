%module viennacl

%{

#include <numo/narray.h>
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

namespace RubyViennacl {

  template<typename T>
  struct narray_traits{
    static VALUE type() { return Qnil; }
  };

  template<>
  struct narray_traits<double>{
    static VALUE type() { return numo_cDFloat; }
  };

  template<>
  struct narray_traits<float>{
    static VALUE type() { return numo_cSFloat; }
  };

  template<>
  struct narray_traits<int32_t>{
    static VALUE type() { return numo_cInt32; }
  };

  template<>
  struct narray_traits<int16_t>{
    static VALUE type() { return numo_cInt16; }
  };

  template<>
  struct narray_traits<char>{
    static VALUE type() { return numo_cInt8; }
  };

  template<>
  struct narray_traits<uint32_t>{
    static VALUE type() { return numo_cUInt32; }
  };

  template<>
  struct narray_traits<uint16_t>{
    static VALUE type() { return numo_cUInt16; }
  };

  template<>
  struct narray_traits<unsigned char>{
    static VALUE type() { return numo_cUInt8; }
  };

  static void adjust_memory_usage(ssize_t n) {
#ifdef HAVE_rb_gc_adjust_memory_usage
    rb_gc_adjust_memory_usage(n);
#endif
  }
};

#include "ops.hpp"
#include "rubyviennacl_base.hpp"

%}

%include std_vector.i
%template() std::vector<double>;
%template() std::vector<std::vector<double> >;
%template() std::vector<float>;
%template() std::vector<std::vector<float> >;
%template() std::vector<int32_t>;
%template() std::vector<std::vector<int32_t> >;
%template() std::vector<int16_t>;
%template() std::vector<std::vector<int16_t> >;
%template() std::vector<char>;
%template() std::vector<std::vector<char> >;

%template() std::vector<uint32_t>;
%template() std::vector<std::vector<uint32_t> >;
%template() std::vector<uint16_t>;
%template() std::vector<std::vector<uint16_t> >;
%template() std::vector<unsigned char>;
%template() std::vector<std::vector<unsigned char> >;

%include "vector.i"
%include "matrix.i"
%include "ops.i"
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

