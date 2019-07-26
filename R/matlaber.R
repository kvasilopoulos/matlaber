#' @importFrom processx run
#' @export
run_matlab <- function(code, save_path = NULL, load_path = NULL,
                       run_arg = c("batch", "interactive"), ...){

  if (!is.null(save_path)) {
    code <- str_prepend(code, "save", save_path)
  }
  if (!is.null(load_path)) {
    code <- str_append(code, "load", load_path)
  }

  run_arg <- match.arg(run_arg)
  if (run_arg == "batch") {
    args <- "-batch"
  }else{
    message("stdout is not supported in reactive mode.")
    args <- c("-nosplash", "-nodesktop", "-r")
    # code <- str_append(code, "exit")
  }

  x <- run("matlab", c(args, code), ...)
  class(x) <-  append("matlaber", class(x))
  x
}

# import_matlab <- function(code, ...) {
#   # TODO basically run, save and read
# }

#' @export
print.matlaber <- function(x, pretty = FALSE) {
  no_ws <- gsub(" ", "", x$stdout)
  new_var <- gsub("\r\n\r\n\r\n","\n", no_ws)
  no_rn <- gsub("\r\n", "", new_var)
  out <- gsub("=", " = ", no_rn)
  cat(out)
}

#' @export
code_env <- function(x) {
  # TODO pass R objects with expression~eval rmat rvec rmat
  code <- substitute(x)
  quoted <- deparse(code)
  quoted <- quoted[-c(1, length(quoted))]
  trimed <- trimws(quoted)
  out <- strip_slashes(trimed)
  paste(out, collapse = "\n ")
}

strip_slashes <- function(x) {
  is_string <- grepl('"', x)
  x <- gsub('"', "", x)
  x[is_string] <- s_quote(x[is_string])
  x
}

s_quote <- function(x) {
  paste0("'", x, "'")
}

mat_env <- function() {
  new.env(parent = globalenv())
}
