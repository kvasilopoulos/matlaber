
#'@export
mat_write <- function(x) {
}


partial_message <- function(msg) {
  type1 <- "MAT file format error"
  type2 <- "Detected non-named objects"
  type3 <- "Detected objects with duplicated names"
  recode_error_message(
    msg,
    search = c(type1, type2, type3),
    replace = c("mpla1", "mpla2", "mpla3"),
    default = NULL
  )
}

partial_message("mpla mpla")


recode_error_message <- function(x, search, replace, default = NULL) {

  # build a nested ifelse function by recursion
  decode_fun <- function(search, replace, default = NULL) {
    if (length(search) == 0L) {
      function(x) if (is.null(default)) x else rep(default, length(x))
    } else {
      function(x) {
        ifelse(x == search[1L], replace[1L],
               decode_fun(tail(search,  -1L), tail(replace, -1L), default)(x))
      }
    }
  }
}

#' @importFrom R.matlab readMat.default
#' @export
mat_read <- function(x) {
  R.matlab::readMat.default()
}
