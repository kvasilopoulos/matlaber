#' Run Matlab
#'
#' @param code code to be evaluated
#' @param load_path specify file path of which to load workspace variables
#' @param save_path specify file path of which to save workspace variables
#' @param run_arg in which mode to be run. Batch is advised
#' @param ... further arguments passe to \code{\link[processx]{run}}.
#' @importFrom processx run
#' @export
#'
#' @examples
#' \dontrun{
#' # Print the paths of matlab
#' mat_run("path")
#'
#' # In strings double quotes should be outside and single quotes inside
#' mat_run("'hello'")
#' }
mat_run <- function(code, load_path = NULL, save_path = NULL,
                       run_arg = c("batch", "interactive"), ...){
  if (!is.null(save_path)) {
    assert_mat(load_path)
    code <- str_prepend(code, "save", save_path)
  }
  if (!is.null(load_path)) {
    assert_mat(save_path)
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

#' Addpath to matlab
#' @param path the path to add
#' @export
mat_addpath <- function(path) {
  path <- paste0("addpath", path, "savepath")
  mat_run(path)
}
