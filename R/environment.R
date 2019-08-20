env_exclude <- function(x) {
  is.function(x) || is.environment(x)
}

filter_global_env <- function(x) {
  sub <- lapply(x, env_exclude )
  sub_idx <- Reduce(c, sub)
  if (is.null(sub_idx)) {
    return(message("Empty global environment"))
  }
  x[!sub_idx]
}

get_global_env <- function() {
  ls_global <- ls(envir = globalenv())
  mget(ls_global, envir = globalenv())
}

mat_global_env <- function() {
  glob_env <- get_global_env()
  filter_global_env(glob_env)
}
