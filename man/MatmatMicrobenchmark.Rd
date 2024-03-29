% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dense_matrix_kernels.R
\name{MatmatMicrobenchmark}
\alias{MatmatMicrobenchmark}
\title{Conducts a single performance trial with the matrix-matrix multiplication
dense matrix kernel}
\usage{
MatmatMicrobenchmark(benchmarkParameters, kernelParameters)
}
\arguments{
\item{benchmarkParameters}{an object of type
\code{\link{DenseMatrixMicrobenchmark}} specifying various parameters
for microbenchmarking the dense matrix kernel}

\item{kernelParameters}{a list of matrices or vectors to be used as input to
the dense matrix kernel}
}
\description{
\code{MatmatMicrobenchmark} conducts a single performance trial of the
matrix-matrix multiplication dense matrix kernel for the matrix given in the
\code{kernelParameters} parameter.  The function times the single function
call \code{kernelParameters$A \%*\% kernelParameters$B}.
}
\examples{
\dontrun{
# Allocate input to the matrix-matrix multiplication microbenchmark for the
# first matrix size to be tested
microbenchmarks <- GetDenseMatrixDefaultMicrobenchmarks()
kernelParameters <- MatmatAllocator(microbenchmarks[["matmat"]], 1)
# Execute the microbenchmark
timings <- MatmatMicrobenchmark(microbenchmarks[["matmat"]], kernelParameters)
}

}
