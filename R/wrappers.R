
#'@export
mat_write <- function(x) {
}

#' @importFrom R.matlab readMat.default
#' @export
mat_read <- function(x) {
  R.matlab::readMat.default()
}
