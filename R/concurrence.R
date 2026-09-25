#' Get the concurrence matrix or table
#'
#' Find the number of common levels of first variable across the levels of the second variable.
#' The diagonal shows the total number of levels at the corresponding level.
#' The off-diagonal shows the number of common levels between the two levels.
#' The matrix is symmetric.
#'
#' @param data A data frame containing the MET data
#' @param x Categorical variable to be used for the concurrence matrix.
#' @param group Categorical grouping variable.
#' @param na.rm Remove NA values when checking for concurrence.
#' @return
#' `concurrence_matrix()` returns a symmetric numeric matrix of class
#' `concurrence_mat` with one row and one column
#' per level of `group`. The diagonal entries give the number of distinct
#' levels of `x` observed at each level of `group`, and the off-diagonal
#' entries give the number of levels of `x` shared by the two corresponding
#' levels of `group`. The names of `x` and `group` are stored in the `.vars`
#' attribute.
#'
#' `concurrence_table()` returns the same information in long format as a
#' tibble of class `concurrence_tbl`, with one row per pair of `group` levels
#' and the columns:
#' \describe{
#'   \item{`<group>_1`, `<group>_2`}{Factors giving the pair of `group` levels.}
#'   \item{`concurrence`}{Number of levels of `x` shared by the pair.}
#'   \item{`prop_in_1`}{Proportion of the levels of `x` in `<group>_1` that
#'     are also in `<group>_2`.}
#'   \item{`prop_in_2`}{Proportion of the levels of `x` in `<group>_2` that
#'     are also in `<group>_1`.}
#' }
#' @examples
#' df <- expand.grid(gen = paste0("G", 1:20), env = paste0("E", 1:15))
#' df <- df[sample(nrow(df), 100), ]
#' (mat <- concurrence_matrix(df, gen, env))
#' extract(mat, "E1", "E2")
#' extract(mat, "E1", c("E2", "E3"))
#' extract(mat, c("E5", "E6", "E7"), c("E2", "E3"))
#' # proportion of levels in the first variable
#' # at each level of the second variable
#' proportions(mat, 1)
#'
#' @export
concurrence_matrix <- function(data, x, group, na.rm = FALSE) {
  x <- tidyselect::eval_select(rlang::enquo(x), data)
  group <- tidyselect::eval_select(rlang::enquo(group), data)
  if (na.rm) {
    data <- data[!is.na(data[[x]]) & !is.na(data[[group]]), ]
  }
  tt <- table(data[[group]], data[[x]]) > 0
  res <- tt %*% t(tt)
  structure(
    res,
    class = c("concurrence_mat", class(res)),
    .vars = c(names(x), names(group))
  )
}

#' @export
print.concurrence_mat <- function(x, n = 10, ...) {
  var1 <- attr(x, ".vars")[1]
  var2 <- attr(x, ".vars")[2]
  cli::cli_bullets(c(
    "*" = "Diagonal shows the total number of levels for {.field {var1}} at the corresponding level for {.field {var2}}",
    "*" = "Off-diagonal shows the number of common levels for {.field {var1}} between the two levels for {.field {var2}}"
  ))
  n <- min(c(n, nrow(x)))
  print(unclass(x)[1:n, 1:n])
  if (n >= nrow(x)) {
    msg <- ""
    trail <- ""
  } else {
    msg <- glue::glue(
      "Showing only {n} {mult_sign()} {n}. Use `print(x, n = ...)` to show more."
    )
    trail <- "\n   ...\n"
  }
  cli::cli_inform(c(
    " " = trail,
    "i" = "Concurrence matrix: {nrow(x)} {mult_sign()} {nrow(x)} {attr(x, '.vars')[2]}. {msg}"
  ))
  invisible(x)
}


#' @rdname concurrence_matrix
#' @export
concurrence_table <- function(data, x, group, na.rm = FALSE) {
  mat <- concurrence_matrix(data, {{ x }}, {{ group }}, na.rm = na.rm)
  inv_mat <- diag(1 / diag(mat))
  dimnames(inv_mat) <- dimnames(mat)
  prop1 <- as.data.frame(inv_mat %*% mat)
  prop2 <- as.data.frame(mat %*% inv_mat)
  res <- as.data.frame(mat)

  grp_var <- attr(mat, ".vars")[2]
  grp_var1 <- paste0(grp_var, "_1")
  grp_var2 <- paste0(grp_var, "_2")
  convert_to_long <- function(dat, name = "concurrence") {
    dat <- dat |>
      tibble::rownames_to_column(grp_var1) |>
      tidyr::pivot_longer(
        -tidyselect::any_of(grp_var1),
        names_to = grp_var2,
        values_to = name
      )
    dat[[grp_var1]] <- factor(dat[[grp_var1]])
    dat[[grp_var2]] <- factor(dat[[grp_var2]])
    dat
  }
  res <- convert_to_long(res, name = "concurrence")
  prop1 <- convert_to_long(prop1, name = "prop_in_1")
  prop2 <- convert_to_long(prop2, name = "prop_in_2")
  res[[grp_var1]] <- stats::reorder(res[[grp_var1]], res[["concurrence"]])
  res[[grp_var2]] <- stats::reorder(res[[grp_var2]], res[["concurrence"]])
  res <- dplyr::left_join(res, prop1, by = c(grp_var1, grp_var2))
  res <- dplyr::left_join(res, prop2, by = c(grp_var1, grp_var2))
  tibble::new_tibble(res, class = "concurrence_tbl", .group_var = grp_var)
}

#' @importFrom pillar tbl_sum
#' @export
tbl_sum.concurrence_tbl <- function(x, ...) {
  grp_var <- attr(x, ".group_var")
  c(
    NextMethod(),
    "Dimension" = paste0(
      dplyr::n_distinct(x[[paste0(grp_var, "_1")]]),
      " ",
      mult_sign(),
      " ",
      dplyr::n_distinct(x[[paste0(grp_var, "_2")]]),
      " environments"
    )
  )
}
