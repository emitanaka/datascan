# Get the concurrence matrix or table

Find the number of common levels of first variable across the levels of
the second variable. The diagonal shows the total number of levels at
the corresponding level. The off-diagonal shows the number of common
levels between the two levels. The matrix is symmetric.

## Usage

``` r
concurrence_matrix(data, x, group, na.rm = FALSE)

concurrence_table(data, x, group, na.rm = FALSE)
```

## Arguments

- data:

  A data frame containing the MET data

- x:

  Categorical variable to be used for the concurrence matrix.

- group:

  Categorical grouping variable.

- na.rm:

  Remove NA values when checking for concurrence.

## Value

A concurrence matrix or table

## Examples

``` r
df <- expand.grid(gen = paste0("G", 1:20), env = paste0("E", 1:15))
df <- df[sample(nrow(df), 100), ]
(mat <- concurrence_matrix(df, gen, env))
#> • Diagonal shows the total number of levels for gen at the corresponding level
#>   for env
#> • Off-diagonal shows the number of common levels for gen between the two levels
#>   for env
#>      
#>       E1 E2 E3 E4 E5 E6 E7 E8 E9 E10
#>   E1   8  4  5  4  2  3  2  2  4   4
#>   E2   4  9  3  4  1  2  1  1  5   4
#>   E3   5  3  9  4  1  5  1  2  6   4
#>   E4   4  4  4  8  1  4  1  1  5   4
#>   E5   2  1  1  1  3  2  0  0  0   1
#>   E6   3  2  5  4  2  7  0  0  4   2
#>   E7   2  1  1  1  0  0  3  2  1   0
#>   E8   2  1  2  1  0  0  2  4  0   2
#>   E9   4  5  6  5  0  4  1  0  9   4
#>   E10  4  4  4  4  1  2  0  2  4   8
#>   ...
#> ℹ Concurrence matrix: 15 × 15 env. Showing only 10 × 10. Use `print(x, n =
#>   ...)` to show more.
extract(mat, "E1", "E2")
#> [1] 4
extract(mat, "E1", c("E2", "E3"))
#> E2 E3 
#>  4  5 
extract(mat, c("E5", "E6", "E7"), c("E2", "E3"))
#>     
#>      E2 E3
#>   E5  1  1
#>   E6  2  5
#>   E7  1  1
# proportion of levels in the first variable
# at each level of the second variable
proportions(mat, 1)
#> • Diagonal shows the total number of levels for gen at the corresponding level
#>   for env
#> • Off-diagonal shows the number of common levels for gen between the two levels
#>   for env
#>      
#>               E1         E2         E3         E4         E5         E6
#>   E1  0.15686275 0.07843137 0.09803922 0.07843137 0.03921569 0.05882353
#>   E2  0.07843137 0.17647059 0.05882353 0.07843137 0.01960784 0.03921569
#>   E3  0.08771930 0.05263158 0.15789474 0.07017544 0.01754386 0.08771930
#>   E4  0.08163265 0.08163265 0.08163265 0.16326531 0.02040816 0.08163265
#>   E5  0.11111111 0.05555556 0.05555556 0.05555556 0.16666667 0.11111111
#>   E6  0.06976744 0.04651163 0.11627907 0.09302326 0.04651163 0.16279070
#>   E7  0.12500000 0.06250000 0.06250000 0.06250000 0.00000000 0.00000000
#>   E8  0.10526316 0.05263158 0.10526316 0.05263158 0.00000000 0.00000000
#>   E9  0.07547170 0.09433962 0.11320755 0.09433962 0.00000000 0.07547170
#>   E10 0.09302326 0.09302326 0.09302326 0.09302326 0.02325581 0.04651163
#>      
#>               E7         E8         E9        E10
#>   E1  0.03921569 0.03921569 0.07843137 0.07843137
#>   E2  0.01960784 0.01960784 0.09803922 0.07843137
#>   E3  0.01754386 0.03508772 0.10526316 0.07017544
#>   E4  0.02040816 0.02040816 0.10204082 0.08163265
#>   E5  0.00000000 0.00000000 0.00000000 0.05555556
#>   E6  0.00000000 0.00000000 0.09302326 0.04651163
#>   E7  0.18750000 0.12500000 0.06250000 0.00000000
#>   E8  0.10526316 0.21052632 0.00000000 0.10526316
#>   E9  0.01886792 0.00000000 0.16981132 0.07547170
#>   E10 0.00000000 0.04651163 0.09302326 0.18604651
#>   ...
#> ℹ Concurrence matrix: 15 × 15 env. Showing only 10 × 10. Use `print(x, n =
#>   ...)` to show more.
```
