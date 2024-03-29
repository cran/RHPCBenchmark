% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sparse_matrix_benchmark.R
\name{GetSparseLuDefaultMicrobenchmarks}
\alias{GetSparseLuDefaultMicrobenchmarks}
\title{Initializes the list of default sparse LU factorization microbenchmarks}
\usage{
GetSparseLuDefaultMicrobenchmarks()
}
\value{
a list of \code{SparseMatrixMicrobenchmark} objects defining the
  microbenchmarks to be executed.  The microbenchmarks appear in the order
  listed in the function description and are assigned the names enumerated
  in the description.
}
\description{
\code{GetSparseLuDefaultMicrobenchmarks} defines the default sparse LU
factorization microbenchmarks to be executed by the
\code{\link{RunSparseMatrixBenchmark}} function.  The current sparse LU
factorization microbenchmarks cover a variety of matrices of different
dimensions and number of non-zero values.  They are as follows:
\enumerate{
  \item lu_circuit5M_dc -- Freescale DC circuit simulation matrix 2600295
    nonzeros
  \item lu_stomach -- 3D electro-physical model matrix with 3021648 nonzeros
  \item lu_torso3 -- 3D electro-physical model matrix with 4429042 nonzeros
}
See the documentation for the
\code{\link{SparseMatrixMicrobenchmark}} class for more details.
}
\seealso{
\code{\link{SparseMatrixMicrobenchmark}}

Other sparse matrix default microbenchmarks: \code{\link{GetSparseCholeskyDefaultMicrobenchmarks}},
  \code{\link{GetSparseCholeskyExampleMicrobenchmarks}},
  \code{\link{GetSparseMatrixVectorDefaultMicrobenchmarks}},
  \code{\link{GetSparseMatrixVectorExampleMicrobenchmarks}},
  \code{\link{GetSparseQrDefaultMicrobenchmarks}}
}
