#' Test for plot equality with 'diff' generation
#'
#' @description
#' This \code{tinytest}-compatible expectation compares two plots supplied as files (which
#' should be png files) and returns \emph{visual} difference in a plot file (for which the
#' designated file has to be supplied).
#'
#' The labels \dQuote{old} (for the reference plot compared against), \dQuote{new} (for
#' the candidate plot, and \dQuote{diff} can be set as value to the global option
#' \code{tinysnapshot_plot_diff_style}. For example settings \code{c("old", "new", "diff")}
#' shows all three, setting \code{c("new", "diff")} just these two. The default is to only show
#' the \sQuote{diff} plot.
#'
#' The data format used for returning the PNG image created is described in
#' \url{https://en.wikipedia.org/wiki/Data_URI_scheme}.
#'
#' @param reference Character value with filename of reference plot, should be png
#' @param proposed Character value with filename of proposed solution, should be png
#' @param difference Character value with filename for difference plot (if plots differ)
#' @param ... Passes on to \code{tinysnapshot::expect_equivalent_images()}
#'
#' @return The \code{tinytest} result object where the \code{diff} attribute contains the
#' suitable value that can be passed onto the JSON output, i.e. a character string beginning
#' with \code{"date:image/png;base64,"} followed with the base64 encoded file. The class
#' attribute is set to \code{c("ttvd", "tinytest")} to signal that it is a 'visual diff' result.
#' 
expect_visual_equal_with_diff <- function(proposed, reference, difference, ...) {

    options("tinysnapshot_tol" = 200) 			# tolerance recommendations 

    res <- expect_equivalent_images(reference,
                                    proposed,
                                    diffpath = difference,
                                    style = getOption("tinysnapshot_plot_diff_style",
                                                      default = "diff"),
                                    ...)
    if (isFALSE(res)) { 			# when there is a difference, report it
        diffplot <- paste0("data:image/png;base64,", base64encode(difference))
        class(res) <- c("ttvd", class(res))
        attr(res, "diffplot") <- diffplot
    }
    res
}
