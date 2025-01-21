#' Test for equality with explicit difference
#'
#' @param current \code{[R object or expression]} Outcome or expression under scrutiny.
#' @param target \code{[R object or expression]} Expected outcome
#' @param tol \code{[numeric]} Test equality to machine rounding. Passed
#'     to \code{\link[base]{all.equal} (tolerance)}
#' @param mode \code{[character]} Comparison mode passed to \code{diffPrint},
#' defaults to using the \dQuote{diffobj.mode} global option value with
#' \dQuote{unified} as fallback if no such option is set
#' @param format \code{[character]} Comparison mode passed to \code{diffPrint},
#' defaults to to using the \dQuote{diffobj.format} global option value with
#' \dQuote{ansi256} as fallback if no such option is set
#' @param ... Passed to \code{all.equal}
#'
#' @return A \code{\link[tinytest]{tinytest}} object. A tinytest object is a
#' \code{logical} with attributes holding information about the
#' test that was run. The class attribute is set to \code{c("ttdo", "tinytest")}
#' to signal that it is a 'diffobj' result.
#'
#' @examples
#' library(tinytest)
#' using(ttdo)
#' expect_equal_with_diff(1 + 1, 2)		# TRUE
#' expect_equal_with_diff(1 - 1, 2)		# FALSE
#' expect_equivalent_with_diff(2, c(x=2))	# TRUE
#' expect_equivalent_with_diff(2, c(x=2))	# TRUE
expect_equal_with_diff <- function(current, target, tol = sqrt(.Machine$double.eps),
                                   mode=getOption("diffobj.mode", "unified"),
                                   format=getOption("diffobj.format","ansi256"),
                                   ...) {

    ## are there differences in data and/or attributes, or just in the attributes?
    ## borrowed with thanks from tinytest itself
    .shortdiff <- function(current, target, ...) {
        equivalent_data <- all.equal(target, current , check_attributes=FALSE , use.names=FALSE, ...)
        if (isTRUE(equivalent_data)) "attr" else "data"
    }

    ## run comparison, construct additional output if difference seen 
    check <- all.equal(target, current, tol=tol, ...)
    if (isTRUE(check)) {
        diff <- NA_character_
        short <- NA_character_
    } else {
        diff <- paste(as.character(diffPrint(target, current, mode=mode, format=format)), collapse="\n")
        short <- .shortdiff(current, target, tolerance=tol)
    }

    ## create test output, subclass if difference
    res <- tinytest(result = isTRUE(check), call = sys.call(sys.parent(1)), diff=diff, short=short)
    if (isFALSE(res)) {
        class(res) <- c("ttdo", class(res))
    }

    res
}

#' @details
#' \code{expect_equivalent_with_diff} calls
#' \code{expect_equal_with_diff} with the extra arguments
#' \code{check.attributes=FALSE} and \code{use.names=FALSE}
#'
#' @rdname expect_equal_with_diff
expect_equivalent_with_diff <- function(current, target, tol = sqrt(.Machine$double.eps), ...){
    out <- expect_equal_with_diff(current, target,
                                  check.attributes = FALSE,
                                  use.names = FALSE,
                                  tol=tol, ...)
    attr(out, 'call') <- sys.call(sys.parent(1))
    out
}
