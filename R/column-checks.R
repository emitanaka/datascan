#' Is it the observational unit?
#'
#' An observational unit is the entity that is being measured in a study. For example, if blood pressure of a person is measured, then the person is the observational unit. If blood pressure is measured multiple times for a person, then the observational unit is the person and the time of measurement.
#'
#' Supply the columns that potentially index the observational unit. The column cannot uniquely identify the row. If the number of rows in the data frame is equal to the number of distinct rows in the selected columns, then it returns TRUE, otherwise FALSE. If TRUE, it checks if any of the columns are redundant.
#'
#' @param .data The data frame
#' @param ... The columns in the data frame that potentially index the observational unit.
#' @param .check_redundancy Logical. If TRUE, checks if any of the columns are redundant.
#' @return A single logical value. `TRUE` if the selected
#'   columns uniquely identify each row of `.data` (and, when
#'   `.check_redundancy = TRUE`, no selected column is redundant), and `FALSE`
#'   otherwise. In an interactive session, a message with the result is also
#'   printed.
#' @examples
#' is_observational_unit(ChickWeight, Time, Chick)
#' is_observational_unit(ChickWeight, Time, Chick, Diet)
#'
#' @export
is_observational_unit <- function(.data, ..., .check_redundancy = TRUE) {
  N <- nrow(.data)
  n <- .data |>
    dplyr::distinct(...) |>
    nrow()

  res <- N == n

  if (res & .check_redundancy) {
    ## Check if any are redundant
    sel_cols <- tidyselect::eval_select(rlang::expr(c(...)), .data)
    for (icol in seq_along(sel_cols)) {
      .n <- .data |>
        dplyr::select(sel_cols[-icol]) |>
        dplyr::distinct() |>
        nrow()

      if (N == .n) {
        cli::cli_alert_danger(paste0(
          format_var(names(sel_cols[icol])),
          " is redundant."
        ))
        res <- FALSE
      }
    }
  }

  if (interactive()) {
    if (res) {
      cli::cli_alert_success("Identifies observational unit")
    } else {
      cli::cli_alert_danger("Not the observational unit")
    }
  }

  invisible(res)
}

#' @rdname is_observational_unit
#' @export
is_obs_unit <- is_observational_unit


#' Identify constant columns
#'
#' Similar to janitor::remove_constant, except this function
#' aims to identify the constant columns without removing them.
#' If there are no constant columns, it will return NA.
#'
#' @param data The data frame
#' @param na.rm Should missing values be removed?
#' @return A character vector of constant columns.
#' @examples
#' df <- data.frame(x1 = 1, x2 = c("A", "B", "C"), x3 = "a")
#' cols_constant(df)
#' @family quality checks
#' @export
cols_constant <- function(data, na.rm = FALSE) {
  cols_multinary(data, na.rm = na.rm, n = 1)
}

#' Identify columns that have certain proportion of missing values
#'
#' Similar to janitor::remove_empty, except this function
#' aims to identify the columns without removing them.
#' If there are no identified columns, it will return NA.
#'
#' @param data The data frame
#' @param cutoff The minimum cutoff for the proportion of missing values.
#' @return A character vector of column names with missing values with at least a certain proportion.
#' @examples
#' # find columns that have any missing values
#' cols_missing(airquality, 0)
#' @family quality checks
#' @export
cols_missing <- function(data, cutoff = 1) {
  cols <- if (cutoff >= 1) {
    colSums(is.na(data)) == nrow(data)
  } else {
    (colSums(is.na(data)) / nrow(data)) >= cutoff
  }
  if (!any(cols)) {
    cli::cli_alert("No identified columns with missing proportion.")
    return(NA)
  }
  colnames(data)[cols]
}


#' Identify rows that have certain proportion of missing values
#'
#' Similar to janitor::remove_empty, except this function
#' aims to identify the columns without removing them.
#' If there are no identified columns, it will return NA.
#'
#' @param data The data frame
#' @param cutoff The minimum cutoff for the proportion of missing values.
#' @return An integer vector of rows with missing values with at least a certain proportion.
#' @examples
#' rows_missing(airquality, 0.1)
#'
#' @export
rows_missing <- function(data, cutoff = 1) {
  rows <- if (cutoff >= 1) {
    rowSums(is.na(data)) == ncol(data)
  } else {
    (rowSums(is.na(data)) / ncol(data)) >= cutoff
  }
  if (!any(rows)) {
    cli::cli_alert("No identified rows with missing proportion.")
    return(NA)
  }
  which(rows)
}

get_one_to_one_value_order <- function(x) {
  if (any(is.na(x))) {
    new_value <- as.integer(factor(x))
    new_value[is.na(new_value)] <- -1L
    ulevels <- unique(new_value)
    new_value <- as.integer(factor(new_value, levels = ulevels))
  } else {
    # same as janitor:::get_one_to_one_value_order
    # but below line is changed to as.character(x)
    # must be character as it can cause duplicated levels below sometimes
    ulevels <- unique(as.character(x))
    new_value <- as.integer(factor(x, levels = ulevels))
  }
  new_value
}

#' Identify columns with all unique values
#'
#' Find columns that have all unique values. If there are no identified columns, it will return NA.
#'
#' @param data The data frame
#' @return A character vector of column names with all unique values.
#' @family quality checks
#' @examples
#' cols_all_unique(ChickWeight)
#'
#' @export
cols_all_unique <- function(data) {
  cols <- sapply(data, function(x) length(unique(x)) == nrow(data))
  if (!any(cols)) {
    cli::cli_alert("No columns with all unique values.")
    return(NA)
  }
  colnames(data)[cols]
}

#' Identify bijective (one-to-one correspondence) columns
#'
#' Any values that have all unique values will not be included in the
#' output. If there are no identified columns, it will return an emtpy list.
#'
#' @param data The data frame
#' @return A list of character vectors of bijective columns.
#' @family quality checks
#' @examples
#' cols_bijective(OrchardSprays)
#'
#' @export
cols_bijective <- function(data) {
  stopifnot(ncol(data) > 0)
  stopifnot(!any(duplicated(names(data))))
  ndistinct_cols <- sapply(data, function(x) length(unique(x)))
  data_alt <- data[, ndistinct_cols < nrow(data), drop = FALSE]
  for (idx in seq_along(data_alt)) {
    data_alt[[idx]] <- get_one_to_one_value_order(data_alt[[idx]])
  }
  remaining_cols <- names(data_alt)
  ret <- list()
  while (length(remaining_cols) > 0) {
    nm1 <- remaining_cols[1]
    remaining_cols <- remaining_cols[-1]
    current_ret <- nm1
    for (nm2 in remaining_cols) {
      if (identical(data_alt[[nm1]], data_alt[[nm2]])) {
        current_ret <- c(current_ret, nm2)
        remaining_cols <- setdiff(remaining_cols, nm2)
      }
    }
    if (length(current_ret) > 1) {
      ret[[length(ret) + 1]] <- current_ret
    }
  }
  if (length(ret) == 0) {
    cli::cli_alert("No bijective columns.")
  }
  ret
}


#' Identify all columns with potential issues
#'
#' This function identifies all columns with potential issues, including all unique values, bijective columns, constant columns, and columns with missing values above a certain cutoff. It returns a list of identified columns for each category and can print the results to the console.
#'
#' @inheritParams cols_missing
#' @inheritParams cols_constant
#' @param print Print the output or not.
#' @return A named list with one element per check.
#' @family quality checks
#' @examples
#' cols_identify_all(airquality)
#'
#' @export
cols_identify_all <- function(data, cutoff = 1, na.rm = FALSE, print = TRUE) {
  x1 <- cols_all_unique(data)
  x2 <- cols_bijective(data)
  x3 <- cols_constant(data, na.rm = na.rm)
  x4 <- cols_missing(data, cutoff = cutoff)
  ret <- list(all_unique = x1, bijective = x2, constant = x3, missings = x4)
  if (print) {
    cli::cli_h1("Checking if all values are unique in a column")
    print(x1)
    cli::cli_h1("Checking if any two columns are bijective")
    print(x2)
    cli::cli_h1("Checking if any column is all constant")
    print(x3)
    cli::cli_h1("Checking if columns with preset cut-off in missing values")
    print(x4)
    return(invisible(ret))
  }
  ret
}

#' @rdname cols_multinary
#' @export
cols_binary <- function(data, na.rm = FALSE) {
  cols_multinary(data, na.rm = na.rm, n = 2)
}

#' @rdname cols_constant
#' @export
cols_unary <- cols_constant

#' @rdname cols_multinary
#' @export
cols_ternary <- function(data, na.rm = FALSE) {
  cols_multinary(data, na.rm = na.rm, n = 3)
}

#' Identify columns with a specific number of unique values
#'
#' This function identifies columns in a data frame that have a specific number of unique values. It can be used to find constant, binary, ternary, or any other n-ary columns. If there are no identified columns, it will return NA.
#'
#' @param data The data frame
#' @param na.rm Logical, whether to remove NA values before counting unique values.
#' @param n The specific number of unique values to look for.
#' @return A character vector of column names that have exactly n unique values.
#' @examples
#' cols_binary(mtcars)
#' @family quality-checks
#' @export
cols_multinary <- function(data, na.rm = FALSE, n = 1) {
  stopifnot(ncol(data) > 0)
  if (nrow(data) <= n) {
    cli::cli_alert("The data has only {n} or fewer rows.")
    return(colnames(data))
  }
  cols <- lapply(X = seq_len(ncol(data)), FUN = function(idx) {
    column_to_test <- if (is.matrix(data)) {
      data[, idx]
    } else {
      data[[idx]]
    }
    length(unique(
      if (na.rm) {
        stats::na.omit(column_to_test)
      } else {
        column_to_test
      }
    )) ==
      n
  })
  cols <- unlist(cols)
  if (!any(cols)) {
    term <- switch(
      n,
      "1" = "constant",
      "2" = "binary",
      "3" = "ternary",
      paste0(n, "-nary")
    )
    cli::cli_alert("No {term} columns.")
    return(NA)
  }
  colnames(data)[cols]
}
