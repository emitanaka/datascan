## code to prepare `DATASET` dataset goes here
# https://datadryad.org/dataset/doi%3A10.5061/dryad.4xgxd25n1
# https://datadryad.org/dataset/doi%3A10.5061/dryad.866t1g22s
# https://datadryad.org/dataset/doi:10.5061/dryad.mkkwh712k

library(tidyverse)
white_clover <- read_csv(here::here(
  "data-raw/Albano_et_al_2026_JEB_Trifolium_Manipulative_Experiment_Data.csv"
)) |>
  mutate(across(Garden:Herbivores, as.factor)) |>
  as_tibble()

usethis::use_data(white_clover, overwrite = TRUE)

watch_tits <- read_csv(here::here("data-raw/Individual_watch_data.csv")) |>
  janitor::clean_names() |>
  as_tibble()

usethis::use_data(watch_tits, overwrite = TRUE)
