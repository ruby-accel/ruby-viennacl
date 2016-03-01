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

namespace RubyViennacl {
  using namespace viennacl;

  using std::sin;
  using std::cos;
  using std::tan;
  using std::asin;
  using std::acos;
  using std::atan;
  using std::sinh;
  using std::cosh;
  using std::tanh;
  using std::exp;
  using std::log;
  using std::log10;
  using std::sqrt;
  using std::pow;
  using std::ceil;
  using std::floor;

  template<typename T>
  vector<T> sin(const vector<T>& v){
    return viennacl::linalg::element_sin(v);
  }
  template<typename T>
  vector<T> cos(const vector<T>& v){
    return viennacl::linalg::element_cos(v);
  }
  template<typename T>
  vector<T> tan(const vector<T>& v){
    return viennacl::linalg::element_tan(v);
  }
  template<typename T>
  vector<T> asin(const vector<T>& v){
    return viennacl::linalg::element_asin(v);
  }
  template<typename T>
  vector<T> acos(const vector<T>& v){
    return viennacl::linalg::element_acos(v);
  }
  template<typename T>
  vector<T> atan(const vector<T>& v){
    return viennacl::linalg::element_atan(v);
  }
  template<typename T>
  vector<T> sinh(const vector<T>& v){
    return viennacl::linalg::element_sinh(v);
  }
  template<typename T>
  vector<T> cosh(const vector<T>& v){
    return viennacl::linalg::element_cosh(v);
  }
  template<typename T>
  vector<T> tanh(const vector<T>& v){
    return viennacl::linalg::element_tanh(v);
  }
  template<typename T>
  vector<T> exp(const vector<T>& v){
    return viennacl::linalg::element_exp(v);
  }
  template<typename T>
  vector<T> log(const vector<T>& v){
    return viennacl::linalg::element_log(v);
  }
  template<typename T>
  vector<T> log10(const vector<T>& v){
    return viennacl::linalg::element_log10(v);
  }
  template<typename T>
  vector<T> sqrt(const vector<T>& v){
    return viennacl::linalg::element_sqrt(v);
  }
  template<typename T>
  vector<T> pow(const vector<T>& v1, const vector<T> &v2){
    return viennacl::linalg::element_pow(v1, v2);
  }
  template<typename T>
  vector<T> ceil(const vector<T>& v){
    return viennacl::linalg::element_ceil(v);
  }
  template<typename T>
  vector<T> floor(const vector<T>& v){
    return viennacl::linalg::element_floor(v);
  }

  typedef matrix_expression<const RubyViennacl::matrix_base<double>,
                            const RubyViennacl::matrix_base<double>,
                            RubyViennacl::op_trans > TransExpMatrixDouble;

};

%}

namespace RubyViennacl {
  template<typename T>
  class vector {
  public:
    vector();
    vector(size_t);
    ~vector();

    size_t size();
    size_t internal_size();
    bool empty();

    %extend {

      void assign(const vector<T>& v) {
        (*$self) = v;
      }

      T __getitem__(const size_t i) {
        return (*$self)(i);
      }

      void __setitem__(size_t i, const T& v){
        (*$self)(i) = v;
      }

      vector<T> __add__(const vector<T>&v){
        return (*$self) + v;
      }

      vector<T> __sub__(const vector<T>&v){
        return (*$self) - v;
      }

      vector<T> __mul__(const T &v){
        return (*$self) * v;
      }

      vector<T> __div__(const T &v){
        return (*$self) / v;
      }

      vector<T> __mul__(const vector<T>& v){
        return viennacl::linalg::element_prod(*$self, v);
      }

      vector<T> div(const vector<T>& v){
        return viennacl::linalg::element_div(*$self, v);
      }

      T inner_prod(const vector<T>& v){
        return viennacl::linalg::inner_prod(*$self, v);
      }

      double norm_1(){
        return viennacl::linalg::norm_1(*$self);
      }

      double norm_2(){
        return viennacl::linalg::norm_2(*$self);
      }

      double norm_inf(){
        return viennacl::linalg::norm_inf(*$self);
      }

      /*
      vector<T> abs(){
        return viennacl::linalg::element_abs(*$self);
      }
      */
      vector<T> fabs(){
        return viennacl::linalg::element_fabs(*$self);
      }

      vector<T> sin(){
        return viennacl::linalg::element_sin(*$self);
      }
      vector<T> cos(){
        return viennacl::linalg::element_cos(*$self);
      }
      vector<T> tan(){
        return viennacl::linalg::element_tan(*$self);
      }
      vector<T> asin(){
        return viennacl::linalg::element_asin(*$self);
      }
      vector<T> acos(){
        return viennacl::linalg::element_acos(*$self);
      }
      vector<T> atan(){
        return viennacl::linalg::element_atan(*$self);
      }
      vector<T> sinh(){
        return viennacl::linalg::element_sinh(*$self);
      }
      vector<T> cosh(){
        return viennacl::linalg::element_cosh(*$self);
      }
      vector<T> tanh(){
        return viennacl::linalg::element_tanh(*$self);
      }
      vector<T> exp(){
        return viennacl::linalg::element_exp(*$self);
      }
      vector<T> log(){
        return viennacl::linalg::element_log(*$self);
      }
      vector<T> log10(){
        return viennacl::linalg::element_log10(*$self);
      }
      vector<T> sqrt(){
        return viennacl::linalg::element_sqrt(*$self);
      }
      vector<T> pow(const vector<T> &v){
        return viennacl::linalg::element_pow(*$self, v);
      }
      vector<T> ceil(){
        return viennacl::linalg::element_ceil(*$self);
      }
      vector<T> floor(){
        return viennacl::linalg::element_floor(*$self);
      }
    }
  };

  %template(VectorDouble) vector<double>;
  //  %template(VectorSFloat) vector<float>;
  // %template(VectorLongInt) vector<long int>;
  //  %template(VectorInt) vector<int>;
  // %template(VectorShortInt) vector<int16_t>;

  vector<double> sin(const vector<double>& v);
  double sin(double);
  vector<double> cos(const vector<double>& v);

  //  %nodefaultctor matrix_expression;
  template<class LHS,class RHS, OP >
  class matrix_expression{
  public:
    matrix_expression(LHS&, RHS&);
    ~matrix_expression();
  };

  %template(TransExpMatrixDouble) matrix_expression< const RubyViennacl::matrix_base<double>,
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
      RubyViennacl::TransExpMatrixDouble* trans_(){
        return new RubyViennacl::matrix_expression<const RubyViennacl::matrix_base<T>, const RubyViennacl::matrix_base<T>, RubyViennacl::op_trans>((*$self), (*$self));
      }

    }
  };
  %template(MatrixDouble) matrix<double>;

};
