#' Run Matlab
#'
#' @importFrom processx run
#' @export
mat_run <- function(code, save_path = NULL, load_path = NULL,
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
    code <- paste(code, "exit")
  }
  x <- run("matlab", c(args, code), ...)
  class(x) <-  append("matlaber", class(x))
  x
}

#' @export
print.matlaber <- function(x, ...) {
  out <- trimws(x$stdout)
  cat("\n--- stdout:\n\n")
  cat(out)
}
