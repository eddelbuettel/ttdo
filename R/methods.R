#' Convert tinytest results to data.frame
#' 
#' This method extends the \code{as.data.frame.tinytest} method to handle 
#' arbitrary attributes attached to each tinytest object.
#'
#' @param x tinytests object
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
makeDataFrame <- function(x) {
    ## Borrowed from tinytest::as.data.frame.tinytests
    call_conv <- function(x) {
        attr(x, "call") <- gsub(" +", " ", paste0(capture.output(print(attributes(x)$call)), collapse = " "))
        x
    }

    ## Merge wrapper
    my_merge <- function(x, y) merge(x, y, all = TRUE)

    ## Convert call from language to character
    x <- lapply(x, call_conv)

    ## Make each test result a data.frame
    x <- lapply(x, function(tt) data.frame(result = isTRUE(tt), attributes(tt)))

    ## Collapse data.frames
    Reduce(my_merge, x)
}
