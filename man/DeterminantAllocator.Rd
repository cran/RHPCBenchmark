% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dense_matrix_kernels.R
\name{DeterminantAllocator}
\alias{DeterminantAllocator}
\title{Allocates and populates input to the matrix determinant dense matrix kernel
microbenchmarks}
\usage{
DeterminantAllocator(benchmarkParameters, index)
}
\arguments{
\item{benchmarkParameters}{an object of type
\code{\link{DenseMatrixMicrobenchmark}} specifying various parameters
needed to generate input for the dense matrix kernel.}

\item{index}{an integer index indicating the dimensions of the matrix or
vector data to be generated as input for the dense matrix kernel.}
}
\description{
\code{DeterminantAllocator} allocates and populates the input to the
matrix determinant dense matrix kernel for the purposes of conducting a
single performance trial with the \code{DeterminantMicrobenchmark} function.
The matrices or vectors corresponding to the \code{index} parameter must be
allocated, initialized and returned in the \code{kernelParameters} list.
}
