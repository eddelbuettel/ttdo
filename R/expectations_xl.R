#' Extensions of equality tests for tinytest 
#' 
#' Building on the tinytest functions for testing equality with optional enhanced object 
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
#' \dQuote{ansi256} as fallback if no such option is set
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
    tt_res <- tinytest::expect_identical(current = current, target = target, info = info)

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


#' Extensions of boolean and messaging tests from tinytest 
#' 
#' Building on the tinytest functions for testing boolean values with additional test 
#' feedback through attributes. 
#' 
#' While tinytest does now support the passing of additional information with the info
#' field in its tests, they are not yet supported in the \code{as.data.frame.tinytests}
#' method.
#'
#' @param current \code{[R object or expression]} Outcome or expression under scrutiny.
#' @param info scalar. Optional user-defined message. Must be a single character string. 
#'     Multiline comments may be separated by "\\n".
#' @param class \code{[character]} For condition signals (error, warning, message)
#'     the class from which the condition should inherit.
#' @param ... Passed to \code{all.equal} and returned as a test attribute
#'
#' @return A \code{\link{tinytest}} object. A tinytest object is a
#' \code{logical} with attributes holding information about the
#' test that was run
#'

#' @examples
#' library(tinytest)
#' using(ttdo)
#' expect_true_xl(TRUE, score = 3) # TRUE
#' expect_true_xl(FALSE, name = "check 1-1==2", score = 1, totalpts = 2) # FALSE
#' 
#' @name ttdo_boolean_and_message_tests
NULL


template = '{
    tt_res <- %2$s(%3$s)
    structure(tt_res, ...)
}'

## Borrowed heavily from checkmate.tinytest
supersize <- function(tt.fun, env = parent.frame()) {
    fun.name = if (!is.character(tt.fun)) deparse(substitute(tt.fun)) else tt.fun
    tt.fun = match.fun(tt.fun)
    fun.args = formals(args(tt.fun))
    x.name = names(fun.args[1L])
    body = sprintf(template, x.name, fun.name, paste0(names(fun.args), collapse = ", "))

    # Append the ... operator to formals
    new.args <- do.call(alist, c(fun.args, alist(... =)))

    new.fun = function() TRUE
    formals(new.fun) = new.args
    body(new.fun) = parse(text = body)
    environment(new.fun) = env

    return(new.fun)
}


#' @rdname ttdo_boolean_and_message_tests
expect_true_xl <- supersize(tinytest::expect_true)

#' @rdname ttdo_boolean_and_message_tests
expect_false_xl <- supersize(tinytest::expect_false)

#' @rdname ttdo_boolean_and_message_tests
expect_null_xl <- supersize(tinytest::expect_null)

#' @rdname ttdo_boolean_and_message_tests
#' @param quiet \code{[logical]} suppress output printed by the current expression (see examples)
expect_silent_xl <- supersize(tinytest::expect_silent)

#' @rdname ttdo_boolean_and_message_tests
#' @param pattern \code{[character]} A regular expression to match the message.
expect_error_xl <- supersize(tinytest::expect_error)

#' @rdname ttdo_boolean_and_message_tests
expect_warning_xl <- supersize(tinytest::expect_warning)

#' @rdname ttdo_boolean_and_message_tests
expect_message_xl <- supersize(tinytest::expect_message)
