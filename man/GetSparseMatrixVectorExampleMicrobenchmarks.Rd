% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sparse_matrix_benchmark.R
\name{GetSparseMatrixVectorExampleMicrobenchmarks}
\alias{GetSparseMatrixVectorExampleMicrobenchmarks}
\title{Initializes the list of example sparse matrix-vector microbenchmarks}
\usage{
GetSparseMatrixVectorExampleMicrobenchmarks()
}
\value{
a list of \code{SparseMatrixMicrobenchmark} objects defining the
  microbenchmarks to be executed.  The microbenchmark for matrix-vector
  operations with the Laplacian operator laplacian7pt_100 is
  returned.
}
\description{
\code{GetSparseMatrixVectorExampleMicrobenchmarks} defines example sparse
matrix-vector microbenchmarks to be executed by the
\code{\link{RunSparseMatrixBenchmark}} function.  The example
matrix-vector microbenchmarks cover the following matrices:
\enumerate{
  \item matvec_laplacian7pt_100 -- 100x100x100 7-point Laplacian operator
}
See the documentation for the
\code{\link{SparseMatrixMicrobenchmark}} class for more details.
}
\seealso{
Other sparse matrix default microbenchmarks: \code{\link{GetSparseCholeskyDefaultMicrobenchmarks}},
  \code{\link{GetSparseCholeskyExampleMicrobenchmarks}},
  \code{\link{GetSparseLuDefaultMicrobenchmarks}},
  \code{\link{GetSparseMatrixVectorDefaultMicrobenchmarks}},
  \code{\link{GetSparseQrDefaultMicrobenchmarks}}
}
