%module viennacl

%{
#include <cstdint>
#include "viennacl/vector.hpp"
#include "viennacl/linalg/inner_prod.hpp"
#include "viennacl/linalg/norm_1.hpp"
#include "viennacl/linalg/norm_2.hpp"
#include "viennacl/linalg/norm_inf.hpp"
#include "viennacl/matrix.hpp"

namespace RubyViennacl {
  using namespace viennacl;
  template<typename T>
  vector<T> sin(const vector<T>& v){
    return linalg::element_sin(v);
  }
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

      void assign(vector<T>& v) {
        (*$self) = v;
      }

      T __getitem__(size_t i) {
        return (*$self)(i);
      }

      void __setitem__(size_t i, const T& v){
        (*$self)(i) = v;
      }

      vector<T> __add__(vector<T>&v){
        return (*$self) + v;
      }

      vector<T> __sub__(vector<T>&v){
        return (*$self) - v;
      }

      vector<T> __mul__(T &v){
        return (*$self) * v;
      }

      vector<T> __div__(T &v){
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

      T norm_1(){
        return viennacl::linalg::norm_1(*$self);
      }

      T norm_2(){
        return viennacl::linalg::norm_2(*$self);
      }

      T norm_inf(){
        return viennacl::linalg::norm_inf(*$self);
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
      vector<T> pow(vector<T> &v){
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
  //  %template(VectorInt) vector<int>;
  //  %template(VectorShort) vector<short>;
  //  %template(VectorChar) vector<char>;
  vector<double> sin(const vector<double>& v);

  template<class T>
  class matrix {
  public:
    matrix(size_t, size_t);
    ~matrix();
  };
  %template(MatrixDouble) matrix<double>;

};
