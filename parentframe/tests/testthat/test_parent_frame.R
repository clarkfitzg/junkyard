
testthat::test_that("Use of parent.frame()", {

f = function(x, y) NULL

#xfinder = function(){
#    frame = parent.frame()
#    evalq(cat("Using x: ", x, "\n"), frame)
#}

trace(f, xfinder)

# Works 
f(1, 2)

# Works
testthat::expect_null(f(1, 2))

})


