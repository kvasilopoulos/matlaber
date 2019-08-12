str_prepend <- function(code, pre, str) {
  paste("\n", code, "\n", pre, str)
}

str_append <- function(code, str, post) {
  paste("\n", code, str, post, ";")
}

str_squotes <- function(x) {
  options(useFancyQuotes = FALSE)
  sQuote(x)
}

str_dquotes <- function(x) {
  options(useFancyQuotes = FALSE)
  dQuote(x)
}

str_collapse <- function(x, type) {
  symbol <- ifelse(type, " , "," ; ")
  paste(x, collapse = symbol)
}

strip_slashes <- function(x) {
  is_string <- grepl('"', x)
  x <- gsub('"', "", x)
  x[is_string] <- str_squotes(x[is_string])
  x
}

enc_brackets <- function(x) {
  paste("[", x, "]")
}

enc_cbrackets <- function(x) {
  paste("{", x, "}")
}

equalto <- function(name, value) {
  paste0(name, " = ", value)
}

ds_quotes <- function(x) {
  gsub('\"','\'', x)
}

sd_quotes <- function(x) {
  gsub('\'','\"', x)
}


