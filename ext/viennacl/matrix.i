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

      compressed_matrix<T> dot(const compressed_matrix<T>& m){
        return viennacl::linalg::prod((*$self), m);
      }

      RubyViennacl::matrix<T> dot(const RubyViennacl::matrix<T>& m){
        return viennacl::linalg::prod((*$self), m);
      }

      RubyViennacl::vector<T> dot(const RubyViennacl::vector<T>& v){
        return viennacl::linalg::prod((*$self), v);
      }

    };

  };
  %template(DFloatSpMatrix) compressed_matrix<double>;
  %template(SFloatSpMatrix) compressed_matrix<float>;

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
        RubyViennacl::adjust_memory_usage(m.size()*m[0].size()*sizeof(T));
        return ret;
      }
      
      %newobject from_narray;
      static RubyViennacl::matrix<T>* from_narray(VALUE na) {
        if (!IsNArray(na)) {
          rb_raise(rb_eArgError, "Numo::NArray expected");
        }
        if ( !rb_obj_is_kind_of(na, RubyViennacl::narray_traits<T>::type()) ) {
          rb_raise(rb_eArgError, "Numo::NArray type not matched");
        }
        if (RNARRAY_NDIM(na)!=2) {
            rb_raise(rb_eArgError, "NArray#ndim == 2 expected");
        } else {
          size_t* shp = RNARRAY_SHAPE(na);
          size_t rows = shp[0];
          size_t cols = shp[1];
          char*  data = RNARRAY_DATA_PTR(na);
          RubyViennacl::adjust_memory_usage(rows*cols*sizeof(T));

          std::vector<std::vector<T> > tmp(rows, std::vector<T>(cols));
          RubyViennacl::matrix<T> *ret = new RubyViennacl::matrix<T>(rows, cols);
          for(int i=0; i < rows; i++) {
            memcpy(tmp[i].data(), data + i*cols*(sizeof(T)/sizeof(char)), cols*sizeof(T));
          }
          RubyViennacl::copy(tmp, *ret);
          return ret;
        }
      }

      VALUE to_narray() {
        size_t rows     = $self->size1();
        size_t cols     = $self->size2();
        size_t len      = rows*cols;
        size_t shape[2] = {rows, cols};
        VALUE  na       = rb_narray_new(RubyViennacl::narray_traits<T>::type(), 2, shape);
        char*  data     = (char *) xmalloc(len*sizeof(T));
        RNARRAY_DATA_PTR(na) = data;

        std::vector<std::vector<T> > tmp(rows, std::vector<T>(cols));
        RubyViennacl::copy(*$self, tmp);
        for(int i=0; i < rows; i++) {
          memcpy(data + i*cols*(sizeof(T)/sizeof(char)), tmp[i].data(), cols*sizeof(T));
        }
        return na;
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

      vector<T> dot(const vector<T>& v){
        RubyViennacl::adjust_memory_usage($self->size2()*sizeof(T));
        return viennacl::linalg::prod((*$self), v);
      }

      vector<T> transpose_dot(const vector<T>& v){
        RubyViennacl::adjust_memory_usage($self->size1()*sizeof(T));
        return viennacl::linalg::prod(viennacl::trans(*$self), v);
      }

      matrix<T> __add__(const matrix<T>& m){
        RubyViennacl::adjust_memory_usage($self->size1()*$self->size2()*sizeof(T));
        return (*$self) + m;
      }

      matrix<T> __sub__(const matrix<T>& m){
        RubyViennacl::adjust_memory_usage($self->size1()*$self->size2()*sizeof(T));
        return (*$self) - m;
      }

      matrix<T> dot(const matrix<T>& m){
        RubyViennacl::adjust_memory_usage($self->size2()*m.size1()*sizeof(T));
        return viennacl::linalg::prod((*$self), m);
      }

      matrix<T> __mul__(const matrix<T>& m){
        RubyViennacl::adjust_memory_usage($self->size1()*$self->size2()*sizeof(T));
        return viennacl::linalg::element_prod((*$self), m);
      }

      matrix<T> __mul__(const T x){
        RubyViennacl::adjust_memory_usage($self->size1()*$self->size2()*sizeof(T));
        return (*$self) * x;
      }

      matrix<T> __div__(const matrix<T>& m){
        RubyViennacl::adjust_memory_usage($self->size1()*$self->size2()*sizeof(T));
        return viennacl::linalg::element_div((*$self), m);
      }

      matrix<T> __pow__(const matrix<T>& m){
        RubyViennacl::adjust_memory_usage($self->size1()*$self->size2()*sizeof(T));
        return viennacl::linalg::element_pow((*$self), m);
      }

      matrix<T> transpose(){
        RubyViennacl::adjust_memory_usage($self->size1()*$self->size2()*sizeof(T));
        return viennacl::trans(*$self);
      }

      %newobject trans_;
      RubyViennacl::matrix_expression<const RubyViennacl::matrix_base<T>, const RubyViennacl::matrix_base<T>, RubyViennacl::op_trans>* trans_(){
        RubyViennacl::adjust_memory_usage($self->size1()*$self->size2()*sizeof(T));
        return new RubyViennacl::matrix_expression<const RubyViennacl::matrix_base<T>, const RubyViennacl::matrix_base<T>, RubyViennacl::op_trans>((*$self), (*$self));
      }

    }
  };
  %template(DFloatMatrix) matrix<double>;
  %template(SFloatMatrix) matrix<float>;
  %template( Int32Matrix) matrix<int32_t>;
  %template( Int16Matrix) matrix<int16_t>;
  %template(  Int8Matrix) matrix<char>;
  %template(UInt32Matrix) matrix<uint32_t>;
  %template(UInt16Matrix) matrix<uint16_t>;
  %template( UInt8Matrix) matrix<unsigned char>;

};
