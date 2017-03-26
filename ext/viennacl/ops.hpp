namespace RubyViennacl {
  using namespace viennacl;

  using std::fabs;
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
  T fabs(const T& v){
    return viennacl::linalg::element_fabs(v);
  }
  template<typename T>
  T sin(const T& v){
    return viennacl::linalg::element_sin(v);
  }
  template<typename T>
  T cos(const T& v){
    return viennacl::linalg::element_cos(v);
  }
  template<typename T>
  T tan(const T& v){
    return viennacl::linalg::element_tan(v);
  }
  template<typename T>
  T asin(const T& v){
    return viennacl::linalg::element_asin(v);
  }
  template<typename T>
  T acos(const T& v){
    return viennacl::linalg::element_acos(v);
  }
  template<typename T>
  T atan(const T& v){
    return viennacl::linalg::element_atan(v);
  }
  template<typename T>
  T sinh(const T& v){
    return viennacl::linalg::element_sinh(v);
  }
  template<typename T>
  T cosh(const T& v){
    return viennacl::linalg::element_cosh(v);
  }
  template<typename T>
  T tanh(const T& v){
    return viennacl::linalg::element_tanh(v);
  }
  template<typename T>
  T exp(const T& v){
    return viennacl::linalg::element_exp(v);
  }
  template<typename T>
  T log(const T& v){
    return viennacl::linalg::element_log(v);
  }
  template<typename T>
  T log10(const T& v){
    return viennacl::linalg::element_log10(v);
  }
  template<typename T>
  T sqrt(const T& v){
    return viennacl::linalg::element_sqrt(v);
  }
  template<typename T>
  T pow(const T& v1, const T &v2){
    return viennacl::linalg::element_pow(v1, v2);
  }
  template<typename T>
  T ceil(const T& v){
    return viennacl::linalg::element_ceil(v);
  }
  template<typename T>
  T floor(const T& v){
    return viennacl::linalg::element_floor(v);
  }
};
