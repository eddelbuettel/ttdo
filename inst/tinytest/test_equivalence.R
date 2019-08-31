library(tinytest)
tinytest::using(ttdo)

notiris <- iris
notiris[2,3] <- 42

expect_false( expect_equal_with_diff(iris, notiris) )
expect_false( expect_equivalent_with_diff(iris, notiris) )
