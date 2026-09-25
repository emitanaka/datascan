#' Is variable nested within another variable?
#'
#' This function checks if a variable is nested within another variable. If the levels in the first variable appear only within the levels of the second variable, it returns TRUE; otherwise, it returns FALSE. The function can also handle NA values based on the `na.rm` parameter.
#'
#' By default, trivial cases of nesting are not counted and it returns
#' FALSE when `x` or `y` is constant (has a single value), `x` has all unique
#' values, or `x` and `y` are bijective (have a one-to-one correspondence).
#' Use `ignore` to choose which of these cases are not counted.
#'
#' @param x,y Vectors of the same size where `x` (child variable) is nested in `y` (parent variable)
#' @param na.rm Remove NA values when checking for nestedness.
#' @param ignore A character vector of trivial cases of nesting to ignore,
#'   i.e. not count as nested. Any of `"constant"` (`x` or `y` has a single
#'   value), `"unique"` (`x` has all unique values) and `"bijective"` (`x` and
#'   `y` have a one-to-one correspondence). Use `NULL` to
#'   count all cases.
#' @return TRUE if the values in vector x are nested within vector y, FALSE
#'   otherwise. It is also FALSE for any trivial case listed in `ignore`.
#' @examples
#' df <- data.frame(
#'   site = rep(c("A", "B"), each = 4),
#'   plot1 = rep(c("A1", "A2", "B1", "B2"), each = 2),
#'   plot2 = rep(c("A1", "A2", "A1", "A2"), each = 2)
#' )
#' is_nested(df$plot1, df$site) # TRUE
#' is_nested(df$plot2, df$site) # FALSE since A1 and A2 appear in both sites
#' df$id <- seq_len(nrow(df))
#' is_nested(df$id, df$site) # FALSE since id has all unique values
#' is_nested(df$id, df$site, ignore = c("constant", "bijective")) # TRUE
#' @export
is_nested <- function(
  x,
  y,
  na.rm = TRUE,
  ignore = c("constant", "unique", "bijective")
) {
  ignore <- match_ignore(ignore)
  if (na.rm) {
    keep <- !is.na(x) & !is.na(y)
    x <- x[keep]
    y <- y[keep]
  }
  if (
    "constant" %in% ignore && (length(unique(x)) == 1 || length(unique(y)) == 1)
  ) {
    return(FALSE)
  }
  if ("unique" %in% ignore && length(unique(x)) == length(x)) {
    return(FALSE)
  }
  if (
    "bijective" %in%
      ignore &&
      identical(get_one_to_one_value_order(x), get_one_to_one_value_order(y))
  ) {
    return(FALSE)
  }
  mat <- concurrence_matrix(data.frame(x, y), x, y, na.rm = na.rm)
  all(mat[lower.tri(mat)] == 0)
}

match_ignore <- function(ignore) {
  if (length(ignore) == 0) {
    return(character())
  }
  match.arg(ignore, c("constant", "unique", "bijective"), several.ok = TRUE)
}


#' Is variable complete within another variable?
#'
#' This function checks if a variable is complete within another variable. If all levels of the first variable appear in all levels of the second variable, it returns TRUE; otherwise, it returns FALSE. The function can also handle NA values based on the `na.rm` parameter.
#'
#' @param x,y Vectors of the same size where `x` (child variable) is checked for completeness within `y` (parent variable)
#' @param na.rm Remove NA values when checking for completeness.
#' @return TRUE if the values in vector x are complete
#' @examples
#' df <- data.frame(
#'   site = c("A", "A", "B", "B"),
#'   plot1 = c("A1", "A2", "B1", "B2"),
#'   plot2 = c("A1", "A2", "A1", "A2")
#' )
#' is_complete(df$plot1, df$site) # FALSE
#' is_complete(df$plot2, df$site) # TRUE
#' @export
is_complete <- function(x, y, na.rm = TRUE) {
  mat <- concurrence_matrix(data.frame(x, y), x, y, na.rm = na.rm)
  all(mat == mat[1])
}

#' Nestedness checks
#'
#' This function checks for nestedness in a data frame. It identifies columns that are nested within other columns, meaning that the values in one column are subsets of the values in another column. The function returns a list of identified nested columns and can print the results to the console.
#'
#' By default, trivial cases of nesting (constant columns, columns with all
#' unique values and pairs of bijective columns) are not reported as nested.
#' Use `ignore` to change this (see [is_nested()]).
#'
#' @param data The data frame to be checked for nestedness.
#' @param na.rm Remove NA values when checking for nestedness.
#' @inheritParams is_nested
#' @return A list of identified nested columns. The first element of each list is the child variable, and the second element is the parent variable.
#' @family quality checks
#' @examples
#' cols_nested(CO2)
#' @export
cols_nested <- function(
  data,
  na.rm = FALSE,
  ignore = c("constant", "unique", "bijective")
) {
  stopifnot(ncol(data) > 0)
  stopifnot(!any(duplicated(names(data))))
  ignore <- match_ignore(ignore)
  nested_cols <- list()
  for (i in seq_along(data)) {
    for (j in seq_along(data)) {
      if (i != j) {
        if (
          is_nested(
            data[[i]],
            data[[j]],
            na.rm = na.rm,
            ignore = ignore
          )
        ) {
          nested_cols[[length(nested_cols) + 1]] <- c(
            names(data)[i],
            names(data)[j]
          )
        }
      }
    }
  }
  if (interactive() && length(nested_cols) == 0) {
    cli::cli_alert("No nested columns found.")
  }
  nested_cols
}

#' Add a row ID column to a data frame
#'
#' This function adds a new column to a data frame containing a unique identifier for each row. The default column name is ".id", but this can be customized using the `name` parameter.
#'
#' @param data A data frame to which the row ID column will be added.
#' @param name The name of the new row ID column. Default is ".id".
#' @return The input data frame with an additional column containing row IDs.
#' @examples
#' df <- data.frame(x = c(1, 2, 3), y = c("a", "b", "c"))
#' add_row_id(df)
#' @export
add_row_id <- function(data, name = ".id") {
  stopifnot(ncol(data) > 0)
  if (name %in% names(data)) {
    cli::cli_alert_danger(paste0(
      "The column name '",
      name,
      "' already exists in the data frame."
    ))
    i <- 1
    while (name %in% names(data)) {
      name <- paste0(name, i)
      i <- i + 1
    }
  }

  data[[name]] <- seq_len(nrow(data))
  data
}
