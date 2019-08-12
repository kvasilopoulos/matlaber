context("trans")

options(stringsAsFactors = FALSE)
vec_lgl <- c(TRUE, FALSE, FALSE, TRUE)
vec_int <- 1:4
vec_dbl <- 1:4 * 1.1
vec_chr <- letters[1:4]

expect_character <- function(object, expected, ...) {
  expect_equal(capture.output(cat(as.character(object))), expected, ...)
}

test_that("atomic vectors", {
  expect_character(mat_trans(vec_lgl), "vec_lgl = [ true , false , false , true ]")
  expect_character(mat_trans(vec_int), "vec_int = [ 1 , 2 , 3 , 4 ]")
  expect_character(mat_trans(vec_dbl), "vec_dbl = [ 1.1 , 2.2 , 3.3 , 4.4 ]")
  expect_character(mat_trans(vec_chr), 'vec_chr = [ "a" , "b" , "c" , "d" ]')

})

arr_df <- data.frame(chr = vec_chr, num = vec_dbl, lgl = vec_lgl)
arr_mat <- matrix(1:8, ncol = 2)

test_that("2d objects", {
  out <- paste0(
  "chr = [ \"a\" ; \"b\" ; \"c\" ; \"d\" ]",
  " num = [ 1.1 ; 2.2 ; 3.3 ; 4.4 ]",
  " lgl = [ true ; false ; false ; true ]",
  " arr_df = table(chr , num , lgl)")
  expect_character(mat_trans(arr_df), out)

  expect_character(mat_trans(arr_df)[1], 'chr = [ "a" ; "b" ; "c" ; "d" ]')
  expect_character(mat_trans(arr_df)[2], "num = [ 1.1 ; 2.2 ; 3.3 ; 4.4 ]")
  expect_character(mat_trans(arr_df)[3], "lgl = [ true ; false ; false ; true ]")
  expect_character(mat_trans(arr_df)[4], "arr_df = table(chr , num , lgl)")

  expect_character(mat_trans(arr_mat), "arr_mat = [ 1 , 5 ; 2 , 6 ; 3 , 7 ; 4 , 8 ]")
})

test_that("unsupprted classes", {
  expect_error(mat_trans(ts(1:00)), "unsupported class")
  expect_error(mat_trans(list(1:00)), "unsupported class")
})
