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
};
