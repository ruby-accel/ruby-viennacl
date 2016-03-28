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

    template<class VecT>
    class cg_solver {
    public:
      cg_solver(const RubyViennacl::linalg::cg_tag&);
      ~cg_solver();

      %extend {
        VecT solve(const RubyViennacl::matrix<VecT::cpu_value_type>& m, const VecT& b){
          return (*$self)(m, b);
        }

        VecT solve(const RubyViennacl::compressed_matrix<VecT::cpu_value_type>& m, const VecT& b){
          return (*$self)(m, b);
        }

        VecT solve(const RubyViennacl::compressed_matrix<VecT::cpu_value_type>& m, const VecT& b,
                const RubyViennacl::linalg::ichol0_precond<
                   RubyViennacl::compressed_matrix<VecT::cpu_value_type> >& precond){
          return (*$self)(m, b, precond);
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

        VecT solve(const RubyViennacl::compressed_matrix<VecT::cpu_value_type>& m, const VecT& b){
          return (*$self)(m, b);
        }
      }
    };
    %template(BiCGStabSolverDouble) bicgstab_solver<RubyViennacl::vector<double> >;
    %template(BiCGStabSolverFloat) bicgstab_solver<RubyViennacl::vector<float> >;

    %rename(GmresTag) gmres_tag;
    struct gmres_tag {
      gmres_tag (double tol, unsigned int max_iterations, unsigned int krylov_dim);
      unsigned int iters();
      double error();
    };

    template<class VecT>
    class gmres_solver {
    public:
      gmres_solver(const gmres_tag&);
      ~gmres_solver();

      %extend {
        VecT solve(const RubyViennacl::matrix<VecT::cpu_value_type>& m, const VecT& b){
          return (*$self)(m, b);
        }

        VecT solve(const RubyViennacl::compressed_matrix<VecT::cpu_value_type>& m, const VecT& b){
          return (*$self)(m, b);
        }
      }
    };
    %template(GMRESSolverDouble) gmres_solver<RubyViennacl::vector<double> >;
    %template(GMRESSolverFloat) gmres_solver<RubyViennacl::vector<float> >;

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
    %template(ICHOL0PrecondDouble) ichol0_precond<RubyViennacl::compressed_matrix<double> >;
    %template(ICHOL0PrecondFloat)  ichol0_precond<RubyViennacl::compressed_matrix<float> >;
  }; // end of namespace linalg
};
