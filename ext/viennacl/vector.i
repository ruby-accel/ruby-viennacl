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
        RubyViennacl::adjust_memory_usage(m.size()*sizeof(T));
        return ret;
      }

      %newobject from_narray;
      static RubyViennacl::vector<T>* from_narray(VALUE na) {
        if (!IsNArray(na)) {
          rb_raise(rb_eArgError, "Numo::NArray expected");
        }
        if (!rb_obj_is_kind_of(na, RubyViennacl::narray_traits<T>::type()) ) {
          rb_raise(rb_eArgError, "Numo::NArray type not matched");
        }
        if (RNARRAY_NDIM(na)!=1) {
            rb_raise(rb_eArgError, "NArray#ndim == 1 expected");
        } else {
          size_t* shp = RNARRAY_SHAPE(na);
          size_t  len = shp[0];
          char*  data = RNARRAY_DATA_PTR(na);
          std::vector<T> tmp(len);
          RubyViennacl::vector<T> *ret = new RubyViennacl::vector<T>(len);
          memcpy(tmp.data(), data, len*sizeof(T));
          RubyViennacl::copy(tmp, *ret);
          RubyViennacl::adjust_memory_usage(len*sizeof(T));
          return ret;
        }
      }

      const std::vector<T> to_a() {
        size_t size = (*$self).size();
        std::vector<T> ret(size);
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
        RubyViennacl::adjust_memory_usage($self->size()*sizeof(T));
        return (*$self) + v;
      }

      vector<T> __sub__(const vector<T>&v){
        RubyViennacl::adjust_memory_usage($self->size()*sizeof(T));
        return (*$self) - v;
      }

      vector<T> __mul__(const T &x){
        RubyViennacl::adjust_memory_usage($self->size()*sizeof(T));
        return (*$self) * x;
      }

      vector<T> __mul__(const vector<T>& v){
        RubyViennacl::adjust_memory_usage($self->size()*sizeof(T));
        return viennacl::linalg::element_prod(*$self, v);
      }

      vector<T> __pow__(const vector<T> &v){
        RubyViennacl::adjust_memory_usage($self->size()*sizeof(T));
        return viennacl::linalg::element_pow(*$self, v);
      }

      vector<T> __div__(const vector<T> &v){
        RubyViennacl::adjust_memory_usage($self->size()*sizeof(T));
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

      vector<T> ceil(){
        RubyViennacl::adjust_memory_usage($self->size()*sizeof(T));
        return viennacl::linalg::element_ceil(*$self);
      }

      vector<T> floor(){
        RubyViennacl::adjust_memory_usage($self->size()*sizeof(T));
        return viennacl::linalg::element_floor(*$self);
      }
    }
  };

  %template(DFloatVector) vector<double>;
  %template(SFloatVector) vector<float>;
  %template( Int32Vector) vector<int32_t>;
  %template( Int16Vector) vector<int16_t>;
  %template(  Int8Vector) vector<char>;
  %template(UInt32Vector) vector<uint32_t>;
  %template(UInt16Vector) vector<uint16_t>;
  %template( UInt8Vector) vector<unsigned char>;

};
