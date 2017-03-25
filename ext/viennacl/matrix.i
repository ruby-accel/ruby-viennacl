namespace RubyViennacl {
  template<class T>
  class compressed_matrix {
  public:
    compressed_matrix();
    compressed_matrix(size_t, size_t);
    ~compressed_matrix();
    
    %extend {

      T __getitem__(size_t i, size_t j){
        return (*$self)(i,j);
      }

      void __setitem__(size_t i, size_t j, const T x){
        (*$self)(i,j) = x;
      }

      compressed_matrix<T> __mul__(const compressed_matrix<T>& m){
        return viennacl::linalg::prod((*$self), m);
      }

      RubyViennacl::matrix<T> __mul__(const RubyViennacl::matrix<T>& m){
        return viennacl::linalg::prod((*$self), m);
      }

      RubyViennacl::vector<T> __mul__(const RubyViennacl::vector<T>& v){
        return viennacl::linalg::prod((*$self), v);
      }

    };

  };
  %template(SpMatrixDouble) compressed_matrix<double>;
  %template(SpMatrixFloat)  compressed_matrix<float>;

  template<class T>
  class matrix {
  public:
    matrix(size_t, size_t);
    ~matrix();

    %extend {
      %newobject create;
      static RubyViennacl::matrix<T>* create(const std::vector<std::vector<T> >& m) {
        RubyViennacl::matrix<T> *ret = new RubyViennacl::matrix<T>(m.size(), m[0].size());
        RubyViennacl::copy(m, *ret);
        return ret;
      }

      const std::vector<std::vector<T> > to_a() {
        std::vector<std::vector<T> > ret((*$self).size1(), std::vector<T>((*$self).size2()));
        RubyViennacl::copy(*$self, ret);
        return ret;
      }

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
      RubyViennacl::matrix_expression<const RubyViennacl::matrix_base<T>, const RubyViennacl::matrix_base<T>, RubyViennacl::op_trans>* trans_(){
        return new RubyViennacl::matrix_expression<const RubyViennacl::matrix_base<T>, const RubyViennacl::matrix_base<T>, RubyViennacl::op_trans>((*$self), (*$self));
      }

    }
  };
  %template(MatrixDouble) matrix<double>;
  %template(MatrixFloat) matrix<float>;
};
