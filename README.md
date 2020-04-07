## ttdo: Extend 'tinytest' with 'diffobj'

[![Build Status](https://travis-ci.org/eddelbuettel/ttdo.svg)](https://travis-ci.org/eddelbuettel/ttdo) 
[![License](https://eddelbuettel.github.io/badges/GPL2+.svg)](https://www.gnu.org/licenses/gpl-2.0.html) 
[![CRAN](https://www.r-pkg.org/badges/version/ttdo)](https://cran.r-project.org/package=ttdo)
[![Dependencies](https://tinyverse.netlify.com/badge/ttdo)](https://cran.r-project.org/package=ttdo) 
[![Downloads](https://cranlogs.r-pkg.org/badges/ttdo?color=brightgreen)](https://www.r-pkg.org/pkg/ttdo)
[![Last Commit](https://img.shields.io/github/last-commit/eddelbuettel/ttdo)](https://github.com/eddelbuettel/ttdo)

### What is it?

A package to extend [tinytest](https://cran.r-project.org/package=tinytest), a lightweight, no-dependency, full-featured unit testing package, with
[diffobj](https://cran.r-project.org/package=diffobj) which compares [R](https://www.R-Project.org) objects with proper `diff` semantics.

So it _tests and compares_ and, in case of differences, provides _informative results_.

### What does that look like?

Glad you asked:

![](https://eddelbuettel.github.io/ttdo/ttdoDemo.png)

### How do install it?

The package is now on [CRAN](https://cran.r-project.org) and can be installed
via a standard

```r
install.packages("ttdo")
```

### Who wrote it?

Dirk Eddelbuettel and Alton Barbehenn

### What license?

GPL (>= 2)

### Thanks go to

Mark van der Loo for the excellent
[tinytest](https://cran.r-project.org/package=tinytest) package, Brodie
Gaslam for the nifty [diffobj](https://cran.r-project.org/package=diffobj)
package and Michel Lang for
[checkmate.tinytest](https://github.com/mllg/checkmate.tinytest)
demonstrating the extensions mechanism.
