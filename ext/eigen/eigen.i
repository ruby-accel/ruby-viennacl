%module "eigen"

%include "ruby-eigen/ext/eigen/rb_error_handle.i"
%import "ruby-eigen/ext/eigen/eigen.i"

%{
#include <Eigen/Core>
#include <Eigen/SparseCore>
%}

%inline %{
namespace Eigen {};
namespace RubyEigen {
  using namespace Eigen;
};
%}

%{

#include "ruby-eigen/ext/eigen/rubyeigen_algo.h"
#include "ruby-eigen/ext/eigen/rubyeigen_base.h"

#define VIENNACL_WITH_EIGEN 1
#include "viennacl/vector.hpp"
#include "viennacl/matrix.hpp"
#include "viennacl/compressed_matrix.hpp"
#include "rubyviennacl_base.hpp"

%}

%exception {
  try {
    $action
  }
  catch (const RubyEigen::EigenRuntimeError &e) {
    /* this rb_raise is called inside SWIG functions. That's ok. */
    rb_raise(rb_eEigenRuntimeError, "%s", e.what());
  } 
  catch (const std::runtime_error &e) {
    rb_raise(rb_eRuntimeError, "%s", e.what());
  }
}

%inline %{
  namespace RubyViennacl {
    void __eigen_to_viennacl__(RubyEigen::MatrixXd& e, RubyViennacl::MatrixDouble& v){
      copy(e, v);
    }
    void __viennacl_to_eigen__(RubyViennacl::MatrixDouble& v, RubyEigen::MatrixXd& e){
      copy(v, e);
    }
  };
%}

