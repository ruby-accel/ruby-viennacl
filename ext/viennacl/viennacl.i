%module viennacl

%include std_vector.i
%template(StdVecDouble) std::vector<double>;
%template(StdVecVecDouble) std::vector<std::vector<double> >;
%template(StdVecFloat) std::vector<float>;
%template(StdVecVecFloat) std::vector<std::vector<float> >;

%{

#include <cstdint>
#include <cmath>
#include "viennacl/vector.hpp"
#include "viennacl/linalg/inner_prod.hpp"
#include "viennacl/linalg/norm_1.hpp"
#include "viennacl/linalg/norm_2.hpp"
#include "viennacl/linalg/norm_inf.hpp"
#include "viennacl/matrix.hpp"
#include "viennacl/linalg/matrix_operations.hpp"
#include "viennacl/linalg/prod.hpp"
#include "viennacl/linalg/direct_solve.hpp"
#include "viennacl/linalg/bicgstab.hpp"
#include "viennacl/linalg/cg.hpp"
#include "viennacl/linalg/mixed_precision_cg.hpp"
#include "viennacl/linalg/gmres.hpp"
#include "viennacl/linalg/ichol.hpp"
#include "viennacl/linalg/ilu.hpp"

#include "viennacl/coordinate_matrix.hpp"

#include "vector.hpp"

#include "rubyviennacl_base.hpp"

%}

%include "vector.i"
%include "matrix.i"

namespace RubyViennacl {
  namespace linalg {
    %rename(LowerTag) lower_tag;
    struct lower_tag {
      static const char* name();
    };
    %rename(UnitLowerTag) unit_lower_tag;
    struct unit_lower_tag {
      static const char* name();
    };
    %rename(UpperTag) upper_tag;
    struct upper_tag {
      static const char* name();
    };
    %rename(UnitUpperTag) unit_upper_tag;
    struct unit_upper_tag {
      static const char* name();
    };

    RubyViennacl::vector<double> solve(const RubyViennacl::matrix<double>&,
                                       const RubyViennacl::vector<double>&,
                                       const RubyViennacl::linalg::lower_tag&);
    RubyViennacl::vector<double> solve(const RubyViennacl::matrix<double>&,
                                       const RubyViennacl::vector<double>&,
                                       const RubyViennacl::linalg::unit_lower_tag&);
    RubyViennacl::vector<double> solve(const RubyViennacl::matrix<double>&,
                                       const RubyViennacl::vector<double>&,
                                       const RubyViennacl::linalg::upper_tag&);
    RubyViennacl::vector<double> solve(const RubyViennacl::matrix<double>&,
                                       const RubyViennacl::vector<double>&,
                                       const RubyViennacl::linalg::unit_upper_tag&);

    RubyViennacl::vector<float> solve(const RubyViennacl::matrix<float>&,
                                      const RubyViennacl::vector<float>&,
                                      const RubyViennacl::linalg::lower_tag&);
    RubyViennacl::vector<float> solve(const RubyViennacl::matrix<float>&,
                                      const RubyViennacl::vector<float>&,
                                      const RubyViennacl::linalg::unit_lower_tag&);
    RubyViennacl::vector<float> solve(const RubyViennacl::matrix<float>&,
                                      const RubyViennacl::vector<float>&,
                                      const RubyViennacl::linalg::upper_tag&);
    RubyViennacl::vector<float> solve(const RubyViennacl::matrix<float>&,
                                      const RubyViennacl::vector<float>&,
                                      const RubyViennacl::linalg::unit_upper_tag&);

    %rename(CgTag) cg_tag;
    struct cg_tag {
      cg_tag(double, unsigned int);
      unsigned int iters();
      double error();
    };

    template<class T>
    class cg_solver {
    public:
      cg_solver(const RubyViennacl::linalg::cg_tag&);
      ~cg_solver();

      %extend {
        T solve(const RubyViennacl::matrix<T::cpu_value_type>& m, const T& b){
          return (*$self)(m, b);
        }
      }
    };
    %template(CGSolverDouble) cg_solver< RubyViennacl::vector<double> >;
    %template(CGSolverFloat)  cg_solver< RubyViennacl::vector<float> >;

    %rename(MixedPrecisionCgTag) mixed_precision_cg_tag;
    struct mixed_precision_cg_tag {
      mixed_precision_cg_tag (double tol, unsigned int max_iterations, float inner_tol);
      unsigned int iters();
      double error();
    };

    %rename(BiCGStabTag) bicgstab_tag;
    struct bicgstab_tag {
      bicgstab_tag (double tol, size_t max_iters, size_t max_iters_before_restart);
    };

    template<class VecT>
    class bicgstab_solver {
    public:
      bicgstab_solver(const bicgstab_tag&);
      ~bicgstab_solver();

      %extend {
        VecT solve(const RubyViennacl::matrix<VecT::cpu_value_type>& m, const VecT& b){
          return (*$self)(m, b);
        }
      }
    };
    %template(BiCGStabSolverDouble) bicgstab_solver<RubyViennacl::vector<double> >;

    %rename(GmresTag) gmres_tag;
    struct gmres_tag {
      gmres_tag (double tol, unsigned int max_iterations, unsigned int krylov_dim);
      unsigned int iters();
      double error();
    };


    %rename(IcholTag) ichol0_tag;
    struct ichol0_tag {
      ichol0_tag();
    };

    template<class MatrixT>
    class ichol0_precond {
    public:
      ichol0_precond(const MatrixT&, const ichol0_tag&);
      ~ichol0_precond();
    };

  };

  template<class LHS,class RHS, OP >
  class matrix_expression{
  public:
    matrix_expression(LHS&, RHS&);
    ~matrix_expression();
  };

  %template(ExpTransMatrixDouble) matrix_expression< const RubyViennacl::matrix_base<double>,
                                                     const RubyViennacl::matrix_base<double>,
                                                     RubyViennacl::op_trans >;
  %template(ExpTransMatrixFloat) matrix_expression< const RubyViennacl::matrix_base<float>,
                                                    const RubyViennacl::matrix_base<float>,
                                                    RubyViennacl::op_trans >;
  %template(ExpTransSpMatrixDouble) matrix_expression< const RubyViennacl::compressed_matrix<double>,
                                                     const RubyViennacl::compressed_matrix<double>,
                                                     RubyViennacl::op_trans >;

};
