% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/machine_learning_benchmark.R
\name{GetClusteringDefaultMicrobenchmarks}
\alias{GetClusteringDefaultMicrobenchmarks}
\title{Initializes the list of default clustering microbenchmarks}
\usage{
GetClusteringDefaultMicrobenchmarks()
}
\value{
a list of \code{ClusteringMicrobenchmark} objects defining the
  microbenchmarks to be executed.  The microbenchmarks appear in the order
  listed in the function description and are assigned the names enumerated
  in the description.
}
\description{
\code{GetClusteringDefaultMicrobenchmarks} defines the default clustering
microbenchmarks to be executed by the
\code{\link{RunMachineLearningBenchmark}} function.  The current clustering
microbenchmarks are:
\enumerate{
   \item{pam_cluster_3_7_2500}{N=3, seven clusters with 2500 vectors per
     cluster, using pam function}
   \item{pam_cluster_3_7_5000}{N=3, seven clusters with 5000 vectors per
     cluster, using pam function}
   \item{pam_cluster_3_7_5715}{N=3, seven clusters with 5715 vectors per
     cluster, using pam function}
   \item{pam_cluster_16_33_1213}{N=16, 33 clusters with 1213 vectors per
     cluster, using pam function}
   \item{pam_cluster_64_33_1213}{N=64, 33 clusters with 1213 vectors per
     cluster, using pam function}
   \item{pam_cluster_16_7_2858}{N=16, seven clusters with 2858 vectors per
     cluster, using pam function}
   \item{pam_cluster_32_7_2858}{N=32, seven clusters with 2858 vectors per
     cluster, using pam function}
   \item{pam_cluster_64_7_5715},{N=64, seven clusters with 5715 vectors per
     cluster, using pam function}
   \item{clara_cluster_64_33_1213}{N=64, 33 clusters with 1213 vectors per
     cluster, using clara function}
   \item{clara_cluster_1000_99_1000}{N=1000, 99 clusters with 1000 vectors
     per cluster, using clara function} 
}
The \code{\link[cluster]{pam}} and \code{\link[cluster]{pam}}
microbenchmarks test those clustering functions.  The pam function
applies a quadratic time algorithm to partition around medoids (pam); the
clara function is a linear time approximation to the partitioning around
medoids algorithm.  See the documentation for the
\code{\link{ClusteringMicrobenchmark}} class for more details.
}
\seealso{
\code{\link{ClusteringMicrobenchmark}}
         \code{\link[cluster]{pam}}
         \code{\link[cluster]{pam}}

Other machine learning default microbenchmarks: \code{\link{GetClusteringExampleMicrobenchmarks}}
}
