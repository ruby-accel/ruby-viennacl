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

      %newobject create;
      static RubyViennacl::vector<T>* create(const std::vector<T>& m) {
        RubyViennacl::vector<T> *ret = new RubyViennacl::vector<T>(m.size());
        RubyViennacl::copy(m, *ret);
        return ret;
      }

      const std::vector<T> to_a() {
        std::vector<T> ret((*$self).size());
        RubyViennacl::copy((*$self), ret);
        return ret;
      }

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
  %template(VectorFloat) vector<float>;

  vector<double> fabs(const vector<double>& v);
  double fabs(double);
  vector<double> sin(const vector<double>& v);
  double sin(double);
  vector<double> cos(const vector<double>& v);
  double cos(double);
  vector<double> tan(const vector<double>& v);
  double tan(double);
  vector<double> asin(const vector<double>& v);
  double asin(double);
  vector<double> acos(const vector<double>& v);
  double acos(double);
  vector<double> atan(const vector<double>& v);
  double atan(double);
  vector<double> sinh(const vector<double>& v);
  double sinh(double);
  vector<double> cosh(const vector<double>& v);
  double cosh(double);
  vector<double> tanh(const vector<double>& v);
  double tanh(double);
  vector<double> exp(const vector<double>& v);
  double exp(double);
  vector<double> log(const vector<double>& v);
  double log(double);
  vector<double> log10(const vector<double>& v);
  double log10(double);
  vector<double> sqrt(const vector<double>& v);
  double sqrt(double);
  vector<double> pow(const vector<double>&, const vector<double>&);
  double pow(double,double);
  vector<double> ceil(const vector<double>& v);
  double ceil(double);
  vector<double> floor(const vector<double>& v);
  double floor(double);

};
