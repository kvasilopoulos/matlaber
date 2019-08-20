get_global_env <- function() {
  ls_global <- ls(envir = global_env())
  mget(ls_global, envir = global_env())
}

env_exclude <- function(x) {
  is.function(x) || is.environment(x)
}

filter_global_env <- function(x) {
  sub <- lapply(x, env_exclude ) %>%
    Reduce(c, .)
  x[!sub]
}

get_global_env() %>%
  filter_global_env()
