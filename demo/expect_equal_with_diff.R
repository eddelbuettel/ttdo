
library(tinytest)
using(ttdo)  ## use tinytest extension mechanism

gooddata <- iris

set.seed(123)
baddata <- iris[ sample(1:nrow(iris), nrow(iris), replace=TRUE), ]

goodsummary <- aggregate(cbind(Sepal.Length, Sepal.Width) ~ Species, gooddata, mean)
badsummary <- aggregate(cbind(Sepal.Length, Sepal.Width) ~ Species, baddata, mean)

expect_equal_with_diff(badsummary, goodsummary)

expect_equal_with_diff(badsummary, goodsummary, mode="unified")
