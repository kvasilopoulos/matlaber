write_mat <- function(x) {

}

read_mat <- function(x) {
  R.matlab::readMat.default()
}

rmat <- function(x) {
  stopifnot(is.matrix(x))
  mat_name <- deparse(substitute(x))

  x <- apply(x, 1, paste, collapse = ", ")
  x <- paste(x, collapse = "; ")
  x <- paste0("[", x, "]")
  x
  paste0(mat_name, " = ", x)

}

# rvec
# rlist
# robj = general converter
