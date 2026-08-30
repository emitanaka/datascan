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
#' @return A concurrence matrix or table
#' @examples
#' df <- expand.grid(gen = paste0("G", 1:20), env = paste0("E", 1:15))
#' df <- df[sample(nrow(df), 100), ]
#' (mat <- concurrence_matrix(df, gen, env))
#' extract(mat, "E1", "E2")
#' extract(mat, "E1", c("E2", "E3"))
#' extract(mat, c("E5", "E6", "E7"), c("E2", "E3"))
#' proportions(mat, 1) # proportion of levels in the first variable at each level of the second variable
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
  res <- as.data.frame(mat)
  grp_var <- attr(mat, ".vars")[2]
  grp_var1 <- paste0(grp_var, "_1")
  grp_var2 <- paste0(grp_var, "_2")
  res <- res |>
    tibble::rownames_to_column(grp_var1) |>
    tidyr::pivot_longer(
      -tidyselect::any_of(grp_var1),
      names_to = grp_var2,
      values_to = "concurrence"
    ) |>
    dplyr::mutate(
      !!grp_var1 := reorder(
        !!rlang::sym(grp_var1),
        concurrence
      ),
      !!grp_var2 := reorder(
        !!rlang::sym(grp_var2),
        concurrence
      )
    ) |>
    dplyr::mutate(
      prop_in_1 = concurrence /
        sum(concurrence[
          !!rlang::sym(grp_var1) == !!rlang::sym(grp_var2)
        ]),
      .by = !!rlang::sym(grp_var1)
    ) |>
    dplyr::mutate(
      prop_in_2 = concurrence /
        sum(concurrence[
          !!rlang::sym(grp_var1) == !!rlang::sym(grp_var2)
        ]),
      .by = !!rlang::sym(grp_var2)
    )
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
