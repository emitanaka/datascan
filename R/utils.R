format_var <- function(x) cli::col_blue(paste0("`", x, "`"))

mult_sign <- function() cli::symbol$times


#' Extract operator
#'
#' See \code{magrittr::extract} for details.
#' This works well in conjunction with the concurrence_matrix function to extract specific rows and columns from the resulting matrix.
#'
#' @name extract
#' @keywords internal
#' @export
#' @importFrom magrittr extract
#' @usage x |> extract(i, j)
NULL
