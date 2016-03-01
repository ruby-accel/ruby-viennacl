%module viennacl

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

#include "vector.hpp"

namespace RubyViennacl {
  typedef matrix_expression<const RubyViennacl::matrix_base<double>,
                            const RubyViennacl::matrix_base<double>,
                            RubyViennacl::op_trans > ExpTransMatrixDouble;
};

%}

%include "vector.i"

namespace RubyViennacl {
  namespace linalg {
    %rename(LowerTag) lower_tag;
    struct lower_tag {
      static const char* name();
    };
    %rename(UnitLowerTag) unit_lower_tag;
    struct unit_lower_tag {
      static const char* name();
    };
    %rename(UpperTag) upper_tag;
    struct upper_tag {
      static const char* name();
    };
    %rename(UnitUpperTag) unit_upper_tag;
    struct unit_upper_tag {
      static const char* name();
    };

    RubyViennacl::vector<double> solve(const RubyViennacl::matrix<double>&,
                                       const RubyViennacl::vector<double>&,
                                       const RubyViennacl::linalg::lower_tag&);
    RubyViennacl::vector<double> solve(const RubyViennacl::matrix<double>&,
                                       const RubyViennacl::vector<double>&,
                                       const RubyViennacl::linalg::unit_lower_tag&);
    RubyViennacl::vector<double> solve(const RubyViennacl::matrix<double>&,
                                       const RubyViennacl::vector<double>&,
                                       const RubyViennacl::linalg::upper_tag&);
    RubyViennacl::vector<double> solve(const RubyViennacl::matrix<double>&,
                                       const RubyViennacl::vector<double>&,
                                       const RubyViennacl::linalg::unit_upper_tag&);

    RubyViennacl::vector<float> solve(const RubyViennacl::matrix<float>&,
                                       const RubyViennacl::vector<float>&,
                                       const RubyViennacl::linalg::lower_tag&);
    RubyViennacl::vector<float> solve(const RubyViennacl::matrix<float>&,
                                       const RubyViennacl::vector<float>&,
                                       const RubyViennacl::linalg::unit_lower_tag&);
    RubyViennacl::vector<float> solve(const RubyViennacl::matrix<float>&,
                                       const RubyViennacl::vector<float>&,
                                       const RubyViennacl::linalg::upper_tag&);
    RubyViennacl::vector<float> solve(const RubyViennacl::matrix<float>&,
                                       const RubyViennacl::vector<float>&,
                                       const RubyViennacl::linalg::unit_upper_tag&);

    %rename(CgTag) cg_tag;
    struct cg_tag {
      cg_tag(double, unsigned int);
      unsigned int iters();
      double error();
    };
    %rename(BicstabTag) bicstab_tag;
    struct bicgstab_tag {
      bicgstab_tag (double tol, size_t max_iters, size_t max_iters_before_restart);
    };
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

  template<class T>
  class matrix {
  public:
    matrix(size_t, size_t);
    ~matrix();

    %extend {

      T __getitem__(size_t i, size_t j){
        return (*$self)(i,j);
      }

      void __setitem__(size_t i, size_t j, const T x){
        (*$self)(i,j) = x;
      }

      vector<T> __mul__(const vector<T>& v){
        return viennacl::linalg::prod((*$self), v);
      }

      vector<T> trans_prod(const vector<T>& v){
        return viennacl::linalg::prod(viennacl::trans(*$self), v);
      }

      matrix<T> __add__(const matrix<T>& m){
        return (*$self) + m;
      }

      matrix<T> __sub__(const matrix<T>& m){
        return (*$self) + m;
      }

      matrix<T> __mul__(const matrix<T>& m){
        return viennacl::linalg::prod((*$self), m);
      }

      matrix<T> __mul__(const T x){
        return (*$self) * x;
      }

      matrix<T> trans(){
        return viennacl::trans(*$self);
      }

      %newobject trans_;
      RubyViennacl::ExpTransMatrixDouble* trans_(){
        return new RubyViennacl::matrix_expression<const RubyViennacl::matrix_base<T>, const RubyViennacl::matrix_base<T>, RubyViennacl::op_trans>((*$self), (*$self));
      }

    }
  };
  %template(MatrixDouble) matrix<double>;

};
