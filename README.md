## ttdo

[![Build Status](https://travis-ci.org/eddelbuettel/ttdo.svg)](https://travis-ci.org/eddelbuettel/ttdo) [![License](https://eddelbuettel.github.io/badges/GPL2+.svg)](http://www.gnu.org/licenses/gpl-2.0.html) [![CRAN](http://www.r-pkg.org/badges/version/ttdo)](https://cran.r-project.org/package=ttdo)  [![Dependencies](https://tinyverse.netlify.com/badge/ttdo)](https://cran.r-project.org/package=ttdo) [![Downloads](http://cranlogs.r-pkg.org/badges/ttdo?color=brightgreen)](http://www.r-pkg.org/pkg/ttdo)

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

Dirk Eddelbuettel

### What license?

GPL (>= 2)

### Thanks go to

Mark van der Loo for the excellent
[tinytest](https://cran.r-project.org/package=tinytest) package, Brodie
Gaslam for the nifty [diffobj](https://cran.r-project.org/package=diffobj)
package and Michel Lang for
[checkmate.tinytest](https://github.com/mllg/checkmate.tinytest)
demonstrating the extensions mechanism.
