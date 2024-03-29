################################################################################
# Copyright 2016 Indiana University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

#' Runs all of the machine learning microbenchmarks
#'
#' \code{RunMachineLearningBenchmark} runs all of the microbenchmarks for
#'   performance testing machine learning functionality
#'
#' This function runs the machine learning microbenchmarks, which are divided
#' into four categories supported by this benchmark, defined in the
#' \code{clusteringMicrobenchmarks} input list.  For each microbenchmark, it
#' attempts to create a separate output file in CSV format containing the
#' performance results for data set and function tested by the microbenchmark.
#' The names of the output files follow the format
#' \code{benchmarkName}_\code{runIdentifier}.csv, where
#' \code{benchmarkName} is specified in the
#' \code{ClusteringMicrobenchmark} object of each microbenchmark and
#' \code{runIdentifier} is an input parameter to this function.  If the file
#' already exists, the results will be appended to the existing file.  Each
#' input list contains instances of the
#' \code{\link{ClusteringMicrobenchmark}} class defining each
#' microbenchmark.  Each microbenchmark object with the
#' \code{active} field set to TRUE will be executed.  The lists of default
#' microbenchmarks are generated by the function
#' \code{\link{GetClusteringDefaultMicrobenchmarks}}.  Each 
#' \code{ClusteringMicrobenchmark} specifies an R data file which contains
#' the data object needed by the microbenchmark.  The needed R data
#' files should either be given in an attached R package or given in the
#' \code{data} subdirectory of the current working directory, and they should
#' have the extension \code{.RData}.  If the linear algebra kernels are
#' multithreaded, by linking to multithreaded BLAS or LAPACK libraries for
#' example, then the number of threads must be retrievable from an environment
#' variable which is set before execution of the R programming environment.
#' The name of the environment variable specifying the number of threads must
#' be provided in the R HPC benchmark environment variable
#' R_BENCH_NUM_THREADS_VARIABLE.  This function will retrieve the number of
#' threads through R_BENCH_NUM_THREADS_VARIABLE so that the number of threads
#' can be printed to the results files and recorded in data frames for reporting
#' purposes.  This function utilizes the number of threads only for reporting
#' purposes and is not used by the benchmark to effect the actual number of
#' threads utilized by the kernels, as that is assumed to be controlled by the
#' numerical library.  An error exception will be thrown if the environment
#' variable R_BENCH_NUM_THREADS_VARIABLE and the variable it is set to are not
#' both set.
#'
#' @param runIdentifier a character string specifying the suffix to be
#'   appended to the base of the file name of the output CSV format files
#' @param resultsDirectory a character string specifying the directory
#'   where all of the CSV performance results files will be saved
#' @param clusteringMicrobenchmarks a list of
#'   \code{ClusteringMicrobenchmark} objects defining the clustering
#'   microbenchmarks to execute as part of the machine learning benchmark.
#'   Default values are provided by the function
#'   \code{\link{GetClusteringDefaultMicrobenchmarks}}.
#' @return a data frame containing the user, system, and elapsed (wall clock)
#'   time of times of each performance trial
#'   
#' @examples 
#' \dontrun{
#' # Set needed environment variables for multithreading.  Only single threading
#' # is used in the example.
#' #
#' # Note: The environment variables are usually set by the user before starting
#' #       the R programming environment; they are set here only to facilitate
#' #       a working example.  See the section on multithreading in the vignette
#' #       for further details.
#' Sys.setenv(R_BENCH_NUM_THREADS_VARIABLE="MKL_NUM_THREADS")
#' Sys.setenv(MKL_NUM_THREADS="1")
#' #
#' # Generate example microbechmarks that can be run in a few minutes; see
#' # the vignette for more involved examples. Clustering microbenchmarks
#' # are defined in the examples.
#' #
#' # Note: These microbenchmarks are different than the microbenchmarks
#' #       generated by \code{\link{GetDenseMatrixDefaultMicrobenchmarks}}.
#' #       They are chosen for their short run times and suitability for
#' #       example code. 
#' exampleMicrobenchmarks <- GetClusteringExampleMicrobenchmarks()
#' # Set the output directory of the CSV summary results files
#' resultsDirectory <- "./MachineLearningExampleOutput"
#' # Create the output directory
#' dir.create(resultsDirectory)
#' # Set an appropriate run identifier
#' runIdentifier <- "example"
#' resultsFrame <- RunMachineLearningBenchmark(runIdentifier, resultsDirectory,
#'    clusteringMicrobenchmarks=exampleMicrobenchmarks)
#'
#' # Create a new clustering microbenchmark that tests the clara method from
#' # the cluster package using a data set with 16 features, 8 clusters, and
#' # 1000 normally distributed feature vectors per cluster. 
#' claraMicrobenchmark <- list()
#' claraMicrobenchmark[["clara_cluster_16_8_1000"]] <- methods::new(
#'    "ClusteringMicrobenchmark",
#'    active = TRUE,
#'    benchmarkName = "clara_cluster_16_8_1000",
#'    benchmarkDescription = "Example of new clara microbenchmark",
#'    dataObjectName = NA_character_,
#'    numberOfFeatures = as.integer(16),
#'    numberOfClusters = as.integer(8),
#'    numberOfFeatureVectorsPerCluster = as.integer(1000),
#'    numberOfTrials = as.integer(3),
#'    numberOfWarmupTrials = as.integer(1),
#'    allocatorFunction = ClusteringAllocator,
#'    benchmarkFunction = ClaraClusteringMicrobenchmark
#' )
#'
#' # Set an appropriate run identifier
#' runIdentifier <- "clara_new"
#' # Run the clara microbenchmark
#' claraResults <- RunMachineLearningBenchmark(runIdentifier, resultsDirectory,
#'    clusteringMicrobenchmarks=claraMicrobenchmark)
#' }
#'
#' @seealso \code{\link{GetClusteringDefaultMicrobenchmarks}}
#'          \code{\link{GetClusteringExampleMicrobenchmarks}}
#' @export
RunMachineLearningBenchmark <- function(runIdentifier,
   resultsDirectory,
   clusteringMicrobenchmarks = GetClusteringDefaultMicrobenchmarks()) {

   numberOfThreads <- GetNumberOfThreads()

   # Loop over all clustering microbenchmarks
   if (length(clusteringMicrobenchmarks) > 0) {
      clusteringResults <- PerformClusteringMicrobenchmarking(
         clusteringMicrobenchmarks, MicrobenchmarkClusteringKernel,
         numberOfThreads, runIdentifier, resultsDirectory)
   } else {
      cat(sprintf("WARN: no clustering microbenchmarks to execute, skipping\n\n"))
   }

   return(clusteringResults)
}


#' Performs microbenchmarking of machine learning functions specified by an
#' input list 
#' 
#' \code{PerformClusteringMicrobenchmarking} performs microbenchmarking
#' of machine learning functionality specified by the input list of
#' \code{ClusteringMicrobenchmark} objects.  Objects with the \code{active}
#' flag set to TRUE indicate that the corresponding microbenchmark will be
#' performed; FALSE indicates that the microbenchmark will be skipped.
#'
#' @param microbenchmarks a list of
#'   \code{ClusteringMicrobenchmark} objects defining the machine learning
#'   microbenchmarks to be executed as part of the machine learning
#'   benchmark.
#' @param microbenchmarkingFunction a function that performs the run time
#'   performance trials, computes the summary performance statistics, and
#'   writes the performance results to standard out, 
#' @param numberOfThreads the number of threads the microbenchmarks are
#'   intended to be executed with; the value is for display purposes only as
#'   the number of threads used is assumed to be controlled through environment
#'   variables
#' @param runIdentifier a character string specifying the suffix to be
#'   appended to the base of the file name of the output CSV format files
#' @param resultsDirectory a character string specifying the directory
#'   where all of the CSV performance results files will be saved
#' @return a data frame containing the benchmark name, user, system, and elapsed
#'   (wall clock) times of each performance trial each microbenchmark
PerformClusteringMicrobenchmarking <- function(microbenchmarks,
   microbenchmarkingFunction, numberOfThreads, runIdentifier,
   resultsDirectory) {

   microbenchmarkResults <- NULL

   if (length(microbenchmarks) > 0) {
      for (i in 1:length(microbenchmarks)) {
         if (microbenchmarks[[i]]$active) {

            benchmarkName <- microbenchmarks[[i]]$benchmarkName
            dataObjectName <- microbenchmarks[[i]]$dataObjectName

            # The data objects are read in to the global environment so that
            # they only have to be read from storage once.
            loadSuccessful <- tryCatch({
               if (!is.na(dataObjectName)) {
                  utils::data(list=c(dataObjectName))
               }

               TRUE
            }, warning = function(war) {
               msg <- sprintf("ERROR: data() threw a warning -- %s", war)
               write(msg, stderr())
               return(FALSE)
            }, error = function(err) {
               msg <- sprintf("ERROR: data() threw an error -- %s", err)
               write(msg, stderr())
               return(FALSE)
            })

            if (loadSuccessful) {
               resultsFrame <- microbenchmarkingFunction(microbenchmarks[[i]], numberOfThreads, resultsDirectory, runIdentifier)
               microbenchmarkResults <- rbind(microbenchmarkResults, resultsFrame)

               if (!is.na(dataObjectName)) {
                  remove(list=c(dataObjectName), envir=.GlobalEnv)
               }

               invisible(gc())
            } else {
               microbenchmarkResults[[benchmarkName]] <- NULL
               msg <- sprintf("ERROR: data() failed to read data object '%s', skipping microbenchmark '%s'",
                  dataObjectName, benchmarkName)
               write(msg, stderr())
            }
         }
      }
   }

   return (microbenchmarkResults)
}


#' Initializes the list of default clustering microbenchmarks
#'
#' \code{GetClusteringDefaultMicrobenchmarks} defines the default clustering
#' microbenchmarks to be executed by the
#' \code{\link{RunMachineLearningBenchmark}} function.  The current clustering
#' microbenchmarks are:
#' \enumerate{
#'    \item{pam_cluster_3_7_2500}{N=3, seven clusters with 2500 vectors per
#'      cluster, using pam function}
#'    \item{pam_cluster_3_7_5000}{N=3, seven clusters with 5000 vectors per
#'      cluster, using pam function}
#'    \item{pam_cluster_3_7_5715}{N=3, seven clusters with 5715 vectors per
#'      cluster, using pam function}
#'    \item{pam_cluster_16_33_1213}{N=16, 33 clusters with 1213 vectors per
#'      cluster, using pam function}
#'    \item{pam_cluster_64_33_1213}{N=64, 33 clusters with 1213 vectors per
#'      cluster, using pam function}
#'    \item{pam_cluster_16_7_2858}{N=16, seven clusters with 2858 vectors per
#'      cluster, using pam function}
#'    \item{pam_cluster_32_7_2858}{N=32, seven clusters with 2858 vectors per
#'      cluster, using pam function}
#'    \item{pam_cluster_64_7_5715},{N=64, seven clusters with 5715 vectors per
#'      cluster, using pam function}
#'    \item{clara_cluster_64_33_1213}{N=64, 33 clusters with 1213 vectors per
#'      cluster, using clara function}
#'    \item{clara_cluster_1000_99_1000}{N=1000, 99 clusters with 1000 vectors
#'      per cluster, using clara function} 
#' }
#' The \code{\link[cluster]{pam}} and \code{\link[cluster]{pam}}
#' microbenchmarks test those clustering functions.  The pam function
#' applies a quadratic time algorithm to partition around medoids (pam); the
#' clara function is a linear time approximation to the partitioning around
#' medoids algorithm.  See the documentation for the
#' \code{\link{ClusteringMicrobenchmark}} class for more details.
#'
#' @return a list of \code{ClusteringMicrobenchmark} objects defining the
#'   microbenchmarks to be executed.  The microbenchmarks appear in the order
#'   listed in the function description and are assigned the names enumerated
#'   in the description.
#' @seealso \code{\link{ClusteringMicrobenchmark}}
#'          \code{\link[cluster]{pam}}
#'          \code{\link[cluster]{pam}}
#' @family machine learning default microbenchmarks
#' @export
GetClusteringDefaultMicrobenchmarks <- function() {
   microbenchmarks <- list()
   microbenchmarks[["pam_cluster_3_7_2500"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "pam_cluster_3_7_2500",
      benchmarkDescription = "Clustering of 17500 3-dimensional feature vectors into seven clusters using pam function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(3),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(2500),
      numberOfTrials = as.integer(3),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringMicrobenchmark
   )

   microbenchmarks[["pam_cluster_3_7_5000"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "pam_cluster_3_7_5000",
      benchmarkDescription = "Clustering of 35000 3-dimensional feature vectors into seven clusters using pam function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(3),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(5000),
      numberOfTrials = as.integer(3),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringMicrobenchmark
   )

   microbenchmarks[["pam_cluster_3_7_5715"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "pam_cluster_3_7_5715",
      benchmarkDescription = "Clustering of 40005 3-dimensional feature vectors into seven clusters using pam function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(3),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(5715),
      numberOfTrials = as.integer(3),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringMicrobenchmark
   )

   microbenchmarks[["pam_cluster_16_33_1213"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "pam_cluster_16_33_1213",
      benchmarkDescription = "Clustering of 40029 16-dimensional feature vectors into 33 clusters using pam function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(16),
      numberOfClusters = as.integer(33),
      numberOfFeatureVectorsPerCluster = as.integer(1213),
      numberOfTrials = as.integer(3),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringMicrobenchmark
   )

   microbenchmarks[["pam_cluster_64_33_1213"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "pam_cluster_64_33_1213",
      benchmarkDescription = "Clustering of 40029 64-dimensional feature vectors into 33 clusters using pam function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(64),
      numberOfClusters = as.integer(33),
      numberOfFeatureVectorsPerCluster = as.integer(1213),
      numberOfTrials = as.integer(3),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringMicrobenchmark
   )

   microbenchmarks[["pam_cluster_16_7_2858"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "pam_cluster_16_7_2858",
      benchmarkDescription = "Clustering of 20006 16-dimensional feature vectors into seven clusters using pam function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(16),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(2858),
      numberOfTrials = as.integer(3),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringMicrobenchmark
   )

   microbenchmarks[["pam_cluster_32_7_2858"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "pam_cluster_32_7_2858",
      benchmarkDescription = "Clustering of 20006 32-dimensional feature vectors into seven clusters using pam function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(32),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(2858),
      numberOfTrials = as.integer(3),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringMicrobenchmark
   )

   microbenchmarks[["pam_cluster_64_7_5715"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "pam_cluster_64_7_5715",
      benchmarkDescription = "Clustering of 40005 64-dimensional feature vectors into seven clusters using pam function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(64),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(5715),
      numberOfTrials = as.integer(3),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringMicrobenchmark
   )

   microbenchmarks[["clara_cluster_64_33_1213"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "clara_cluster_64_33_1213",
      benchmarkDescription = "Clustering of 40029 64-dimensional feature vectors into 33 clusters using clara function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(64),
      numberOfClusters = as.integer(33),
      numberOfFeatureVectorsPerCluster = as.integer(1213),
      numberOfTrials = as.integer(3),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = ClaraClusteringMicrobenchmark
   )

   microbenchmarks[["clara_cluster_1000_99_1000"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "clara_cluster_1000_99_1000",
      benchmarkDescription = "Clustering of 99000 1000-dimensional feature vectors into 99 clusters using clara function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(1000),
      numberOfClusters = as.integer(99),
      numberOfFeatureVectorsPerCluster = as.integer(1000),
      numberOfTrials = as.integer(3),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = ClaraClusteringMicrobenchmark
   )

   return (microbenchmarks)
}


#' Initializes the list of example clustering microbenchmarks
#'
#' \code{GetClusteringExampleMicrobenchmarks} defines the example clustering
#' microbenchmarks to be executed by the
#' \code{\link{RunMachineLearningBenchmark}} function.  The example
#' are chosen so that they can run in a few minutes or less.
#' \enumerate{
#'    \item{pam_cluster_3_7_2500}{N=3, seven clusters with 2500 vectors per
#'      cluster}
#'    \item{clara_cluster_64_33_1213}{N=64, 33 clusters with 1213 vectors per
#'      cluster}
#' }
#' See the documentation for the
#' \code{\link{ClusteringMicrobenchmark}} class for more details.
#'
#' @return a list of \code{ClusteringMicrobenchmark} objects defining the
#'   microbenchmarks to be executed.  Microbenchmarks for the \code{pam}
#'   and \code{clara} functions from the \code{cluster} package are
#'   provided.
#' @family machine learning default microbenchmarks
#' @export
GetClusteringExampleMicrobenchmarks <- function() {
   microbenchmarks <- list()
   microbenchmarks[["pam_cluster_3_3_1000"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "pam_cluster_3_3_1000",
      benchmarkDescription = "Clustering of 3000 3-dimensional feature vectors into three clusters using pam function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(3),
      numberOfClusters = as.integer(3),
      numberOfFeatureVectorsPerCluster = as.integer(1000),
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringMicrobenchmark
   )

   microbenchmarks[["clara_cluster_3_3_1000"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "clara_cluster_3_3_1000",
      benchmarkDescription = "Clustering of 1000 3-dimensional feature vectors into three clusters using clara function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(3),
      numberOfClusters = as.integer(3),
      numberOfFeatureVectorsPerCluster = as.integer(1000),
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = ClaraClusteringMicrobenchmark
   )

   return (microbenchmarks)
}

