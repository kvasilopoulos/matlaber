str_prepend <- function(code, pre, str) {
  paste("\n", code, "\n", pre, str)
}

str_append <- function(code, str, post) {
  paste("\n", code, str, post, ";")
}
