.onLoad = function(libname, pkgname) {
    ns <- getNamespace(pkgname)
    expectations <- names(ns)[grepl("^expect_", names(ns))]
    tinytest::register_tinytest_extension(pkgname, expectations)
}
