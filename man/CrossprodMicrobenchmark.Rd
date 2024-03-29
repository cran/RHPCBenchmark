% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dense_matrix_kernels.R
\name{CrossprodMicrobenchmark}
\alias{CrossprodMicrobenchmark}
\title{Conducts a single performance trial with the matrix cross product dense
matrix kernel}
\usage{
CrossprodMicrobenchmark(benchmarkParameters, kernelParameters)
}
\arguments{
\item{benchmarkParameters}{an object of type
\code{\link{DenseMatrixMicrobenchmark}} specifying various parameters
for microbenchmarking the dense matrix kernel}

\item{kernelParameters}{a list of matrices or vectors to be used as input to
the dense matrix kernel}
}
\description{
\code{CrossprodMicrobenchmark} conducts a single performance trial of the
matrix cross product dense matrix kernel for the matrix given in the
\code{kernelParameters} parameter.  The function times the single function
call \code{crossprod(kernelParameters$A)}.
}
\examples{
\dontrun{
# Allocate input to the matrix cross product microbenchmark for the first
# matrix size to be tested
microbenchmarks <- GetDenseMatrixDefaultMicrobenchmarks()
kernelParameters <- CrossprodAllocator(microbenchmarks[["crossprod"]], 1)
# Execute the microbenchmark
timings <- CrossprodMicrobenchmark(microbenchmarks[["crossprod"]], kernelParameters)
}

}
