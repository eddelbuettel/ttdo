#' Convert tinytest results to data.frame
#' 
#' This method extends the \code{as.data.frame.tinytest} method to handle 
#' arbitrary attributes attached to each tinytest object. You can pass in 
#' the results of a single test (a tinytest object) directly or the results 
#' of one of the \code{run_test_*} functions (a tinytests object). 
#' 
#' @param x a tinytest or tinytests object
#'
#' @examples
#' # create a test file in tempdir
#' tests <- "
#' using(ttdo)
#' 
#' addOne <- function(x) x + 2
#'
#' expect_true(addOne(0) > 0)
#' expect_equal(2, addOne(1))
#' "
#' testfile <- tempfile(pattern = "test_", fileext = ".R")
#' write(tests, testfile)
#'
#' # extract testdir
#' testdir <- dirname(testfile)
#' # run all files starting with 'test' in testdir
#' library(tinytest)
#' out <- run_test_dir(testdir)
#' #
#' # convert results
#' dat <- makeDataFrame(out)
#' dat
#' 
#' dat2 <- makeDataFrame(expect_equal_xl(1-1, 2, useDiffObj = FALSE, name = 'subtr', pts = 1))
makeDataFrame <- function(x) {
    ## Borrowed from tinytest::as.data.frame.tinytests
    call_conv <- function(x) {
        attr(x, "call") <- gsub(" +", " ", paste0(capture.output(print(attributes(x)$call)), collapse = " "))
        x
    }

    ## Merge wrapper
    my_merge <- function(x, y) merge(x, y, all = TRUE)
    
    ## If passes a test result directly, make it a list like results from the run_test_* functions
    x <- ifelse(is.list(x), x, list(x))

    ## Convert call from language to character
    x <- lapply(x, call_conv)

    ## Make each test result a data.frame
    x <- lapply(x, function(tt) data.frame(result = isTRUE(tt), attributes(tt)[1:8]))

    ## Collapse data.frames
    Reduce(my_merge, x)
}
