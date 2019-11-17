#' Extensions of equality tests for tinytest 
#' 
#' Building on the tinytest functions for testing equalty with optional enhanced object 
#' diffing and additional test feedback through addtional attributes. 
#' 
#' While tinytest does now support the passing of additional information with the info
#' field in its tests, they are not yet supported in the \code{as.data.frame.tinytests}
#' method.
#'
#' @param current \code{[R object or expression]} Outcome or expression under scrutiny.
#' @param target \code{[R object or expression]} Expected outcome
#' @param useDiffObj \code{[logical]} Whether you should use \code{diffPrint} for the diff field 
#' in the resulting tinytest object 
#' @param tol \code{[numeric]} Test equality to machine rounding. Passed
#'     to \code{\link[base]{all.equal} (tolerance)}
#' @param info An additional attribute to pass around with the tinytest object
#' @param mode \code{[character]} Comparison mode passed to \code{diffPrint},
#' defaults to using the \dQuote{diffobj.mode} global option value with
#' \dQuote{unified} as fallback if no such option is set
#' @param format \code{[character]} Comparison mode passed to \code{diffPrint},
#' defaults to to using the \dQuote{diffobj.format} global option value with
#' \dQuote{raw} as fallback if no such option is set
#' @param ... Passed to \code{all.equal} and returned as a test attributes
#'
#' @return A \code{\link{tinytest}} object. A tinytest object is a
#' \code{logical} with attributes holding information about the
#' test that was run
#'
#' @examples
#' library(tinytest)
#' using(ttdo)
#' expect_equal_xl(1 + 1, 2, score = 3) # TRUE
#' expect_equal_xl(1 - 1, 2, name = "check 1-1==2", score = 1, totalpts = 2) # FALSE
expect_equal_xl <- function(current, target, useDiffObj = TRUE, 
                            tol = sqrt(.Machine$double.eps), info = NA_character_,
                            mode = getOption("diffobj.mode", "unified"),
                            format = getOption("diffobj.format", "ansi256"),
                            ...) {
    # Run tinytest unittest
    tt_res <- tinytest::expect_equal(current = current, target = target, tol = tol, info = info, ...)

    # Add custom object diff (if requested)
    if (useDiffObj)
        attr(tt_res, "diff") <- paste(as.character(diffPrint(current = current, target = target, mode = mode, format = format)), collapse = "\n")

    # Append all extra parameters as test attributes 
    structure(tt_res, ...)
}


#' @rdname expect_equal_xl
expect_identical_xl <- function(current, target, useDiffObj = TRUE, info = NA_character_, 
                                mode = getOption("diffobj.mode", "unified"),
                                format = getOption("diffobj.format", "ansi256"),
                                ...) {
    # Run tinytest unittest
    tt_res <- tinytest::expect_equivalent(current = current, target = target, info = info)

    # Add custom object diff (if requested)
    if (useDiffObj)
        attr(tt_res, "diff") <- paste(as.character(diffPrint(current = current, target = target, mode = mode, format = format)), collapse = "\n")

    # Append all extra parameters as test attributes 
    structure(tt_res, ...)
}


#' @rdname expect_equal_xl
expect_equivalent_xl <- function(current, target, useDiffObj = TRUE, 
                                 tol = sqrt(.Machine$double.eps), info = NA_character_,
                                 mode = getOption("diffobj.mode", "unified"),
                                 format = getOption("diffobj.format", "ansi256"),
                                 ...) {
    # Run tinytest unittest
    tt_res <- tinytest::expect_equivalent(current = current, target = target, tol = tol, info = info, ...)

    # Add custom object diff (if requested)
    if (useDiffObj)
        attr(tt_res, "diff") <- paste(as.character(diffPrint(current = current, target = target, mode = mode, format = format)), collapse = "\n")

    # Append all extra parameters as test attributes 
    structure(tt_res, ...)
}
