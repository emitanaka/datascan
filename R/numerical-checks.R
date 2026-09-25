#' Coerce to numerical and identify non-numerical entries
#'
#' This function attempts to coerce a variable to numerical and identifies any non-numerical entries. It returns the coerced numerical vector and prints a message indicating any non-numerical entries found.
#'
#' Factors are coerced using their labels rather than their underlying integer codes.
#'
#' @param x A vector to be coerced to numerical.
#' @return A numerical vector with non-numerical entries coerced to NA.
#' @examples
#' as_numerical(c("1", "2", "A", "4", "B"))
#' as_numerical(factor(c("10", "20", "A")))
#' @family numerical
#' @export
as_numerical <- function(x) {
  if (is.numeric(x)) {
    return(x)
  } else {
    if (is.factor(x)) {
      x <- as.character(x)
    }
    x_num <- suppressWarnings(as.numeric(x))
    if (any(is.na(x_num) & !is.na(x))) {
      cli::cli_alert_danger(paste0(
        "Non-numerical entries found: ",
        paste(unique(x[is.na(x_num) & !is.na(x)]), collapse = ", ")
      ))
    }
    return(x_num)
  }
}

#' Is the variable numerical?
#'
#' This function checks if a variable is numerical. It returns TRUE if the variable is numerical and FALSE otherwise. If non-numerical entries are found, it prints a message indicating the non-numerical entries.
#'
#' @param x A vector to be checked for numericality.
#' @return TRUE if the variable is numerical, FALSE otherwise.
#' @examples
#' is_numerical(c("1", "2", "3"))
#' is_numerical(c("1", "2", "3", "A"))
#' @family numerical
#' @export
is_numerical <- function(x) {
  if (is.numeric(x)) {
    return(TRUE)
  } else {
    if (is.factor(x)) {
      x <- as.character(x)
    }
    x_num <- suppressWarnings(as.numeric(x))
    if (any(is.na(x_num) & !is.na(x))) {
      cli::cli_alert_danger(paste0(
        "Non-numerical entries found: ",
        paste(unique(x[is.na(x_num) & !is.na(x)]), collapse = ", ")
      ))
      return(FALSE)
    }
    return(TRUE)
  }
}
