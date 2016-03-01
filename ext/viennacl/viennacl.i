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
    %rename(UnitUpperTag) unit_lower_tag;
    struct unit_upper_tag {
      static const char* name();
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
