%module "eigen"

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
#include "viennacl/vector.hpp"
#include "viennacl/matrix.hpp"
#include "viennacl/compressed_matrix.hpp"

%}
