#' Native Matlab translator for R objects
#'
#' Translater R object into Matlab code. Can be used efficiently into a `mat_init` chain and passed into
#' `mat_run`.
#'
#' @param object An R object. Accomodates translation for atomic vectors (numberic, character and logical),
#' and for matrix and data.frame.
#' @param assign_name whether to assign the name of the R object. Default is TRUE.
#' @param byrow whether to fill by row on by column. Used only for atomic vectors.
#'
#'
#' @export
mat_trans <- function(object, assign_name = TRUE, byrow = TRUE) {
  UseMethod("mat_trans")
}

#'@export
mat_trans.default <- function(object,  assign_name, byrow) {
  stop("unsupported class", call. = FALSE)
}

#'@export
mat_trans.numeric <- function(object, assign_name = TRUE, byrow = TRUE) {
  value <- str_collapse(object,  byrow)
  value <- enc_brackets(value)
  if (assign_name) {
    mat_name <- deparse(substitute(object))
    value <- equalto(mat_name, value)
  }
  class(value) <- append("mat_trans", class(value))
  value
}

#'@export
mat_trans.logical <- function(object, assign_name = TRUE, byrow = TRUE) {
  value <- tolower(object)
  value <- str_collapse(value, byrow)
  value <- enc_brackets(value)
  if (assign_name) {
    mat_name <- deparse(substitute(object))
    value <- equalto(mat_name, value)
  }
  class(value) <- append("mat_trans", class(value))
  value
}

#'@export
mat_trans.character <- function(object, assign_name = TRUE, byrow = TRUE) {
  value <- sd_quotes(str_dquotes(object))
  value <- str_collapse(value, byrow)
  value <- enc_brackets(value)
  if (assign_name) {
    mat_name <- deparse(substitute(object))
    value <- equalto(mat_name, value)
  }
  class(value) <- append("mat_trans", class(value))
  value
}


# 2d objects --------------------------------------------------------------

warn_redundant <- function(x) {
  if (!is.null(x)) {
    warning("Argument 'byrow' is redundant in non-atomic objects.",
            call. = FALSE)
  }
}

mat_trans.matrix <- function(object,  assign_name = TRUE, byrow = NULL) {
  warn_redundant(byrow)
  value <- apply(object, 1, paste, collapse = " , ")
  value <- paste(value, collapse = " ; ")
  value <- enc_brackets(value)
  if (assign_name) {
    mat_name <- deparse(substitute(object))
    value <- equalto(mat_name, value)
  }
  class(value) <- "mat_trans"
  value
}


#' @export
mat_trans.data.frame <- function(object, assign_name = TRUE, byrow = NULL) {
  warn_redundant(byrow)
  nms <- names(object)
  nc <- ncol(object)
  value <- vector("character")
  for (i in 1:nc) {
    value[i] <-
      paste0(nms[i], " = ",
             mat_trans(object[, i], byrow = FALSE, assign_name = FALSE))
  }
  cnames <- paste0("table(", paste(nms, collapse = " , "), ")")
  if (assign_name) {
    mat_name <- deparse(substitute(object))
    value[nc + 1] <- paste0(mat_name, " = ", cnames)
  }else{
    value[nc + 1] <- cnames
  }
  class(value) <- "mat_trans"
  value
}

#' @export
print.mat_trans <- function(x, ...) {
  cat(x, sep = "\n")
}


