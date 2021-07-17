\name{NEWS}
\title{News for Package \pkg{ttdo}}
\newcommand{\ghpr}{\href{https://github.com/eddelbuettel/ttdo/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/eddelbuettel/ttdo/issues/#1}{##1}}

\section{Changes in \pkg{ttdo} version 0.0.8 (2021-07-17)}{
  \itemize{
    \item Expand sprintf template to suppress R warning
  }
}

\section{Changes in \pkg{ttdo} version 0.0.7 (2021-07-06)}{
  \itemize{
    \item The CI setup was updated to use \code{run.sh} from
    \href{https://eddelbuettel.github.io/r-ci/}{r-ci} (Dirk).
    \item The package was updated for an API extension in \pkg{tinytest}
    1.3.1 or later (Mark van der Look in \ghpr{7})
    \item The unused \code{LazyData} field was removed from
    \code{DESCRIPTION} (Dirk)
  }
}

\section{Changes in \pkg{ttdo} version 0.0.6 (2020-07-27)}{
  \itemize{
    \item Correct a minor editing mistake spotted by John Blischak.
  }
}

\section{Changes in \pkg{ttdo} version 0.0.5 (2020-05-06)}{
  \itemize{
    \item Rebuilt under \pkg{tinytest} 1.2.0 to add support for
    \code{class} argument in error-code test predicates
  }
}

\section{Changes in \pkg{ttdo} version 0.0.4 (2019-11-18)}{
  \itemize{
    \item Generalize \pkg{tinytest} extensions with additional arguments for
    test predicates (Alton in \ghpr{2}).
    \item Use Travis CI for continuous integration off GitHub (Dirk).
  }
}

\section{Changes in \pkg{ttdo} version 0.0.3 (2019-09-08)}{
  \itemize{
    \item Added a simple demo to support initial CRAN upload.
  }
}

\section{Changes in \pkg{ttdo} version 0.0.2 (2019-08-31)}{
  \itemize{
    \item Updated defaults for \code{format} and \code{mode} to use the
    same \code{options} used by \pkg{diffobj} along with fallbacks.
  }
}

\section{Changes in \pkg{ttdo} version 0.0.1 (2019-08-26)}{
  \itemize{
    \item Initial version, with thanks to both Mark and Brodie.
  }
}
    
