namespace RubyViennacl {
  using namespace viennacl;
  typedef matrix_expression<const RubyViennacl::matrix_base<double>,
                            const RubyViennacl::matrix_base<double>,
                            RubyViennacl::op_trans > ExpTransMatrixDouble;
  typedef matrix<double> MatrixDouble;
  typedef compressed_matrix<double> SpMatrixDouble;
};
