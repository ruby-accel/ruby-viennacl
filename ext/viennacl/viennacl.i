%module viennacl

%{
#include "viennacl/vector.hpp"

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
  class vector{
  public:
    vector();
    vector(size_t);
    ~vector();

    size_t size();
    size_t internal_size();
    bool empty();

    %extend {
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

      vector<T> sin(){
        return viennacl::linalg::element_sin(*$self);
      }
    }
  };

  %template(VectorDouble) vector<double>;
  vector<double> sin(const vector<double>& v);
};
