# Coordination of care by breeders and helpers in the cooperatively breeding long-tailed tit

- `id`: Unique identifier for each provisioning watch

- `feeds`: Number of feeds by each individual per watch

- `data_type`: Whether the data was taken directly from field
  observation (observed) or from null model randomization (expected)

- `alt_feeds`: Number of alternated visits

- `percent_alt`: Percentage of each carer's visits which were alternated

- `sync_feeds`: Number of synchronized visits (2-minute interval)

- `percent_sync2mins`: Percentage of each carer's visits which were
  synchronized (2-minute interval)

- `carer_status`: Factor designating whether a carer was a breeding
  female (female), breeding male (male) or non-breeding helper (helper)

- `carer_id`: The unique identifier for each carer

- `total_feed_rate`: The number of feeds performed by all carers per
  hour

- `brood_size`: The number of days, since recorded hatching, that a
  watch was performed

- `carer_number`: The number of carers observed provisioning during a
  given watch

- `watch_duration`: The time, in minutes, between the first and last
  recorded feed during a given watch

- `watch_time`: Number of hours since the start of the day 00:00 the
  watch was started

- `brood_age`: The number of days, since recorded hatching, that a watch
  was performed

- `julian_hatch_date`: The number of days since March 1 each year that
  the eggs hatched

- `a_max`: The total percentage of visits during a given watch which
  could theoretically be alternated (or synchronized). Formula as
  follows: 100 - ((Number of feeds by highest feed rate carer - Number
  of feeds by all remaining carers)/Total number of feeds)\*100

- `year`: Unique identifier for each year the watch was performed during

- `nest`: Unique identifier for each nest

- `individual_feed_rate`: The number of feeds performed by each carer
  per hour

- `row_ref`: Row reference 1-7950

## Usage

``` r
watch_tits
```

## Format

An object of class `spec_tbl_df` (inherits from `tbl_df`, `tbl`,
`data.frame`) with 7950 rows and 21 columns.

## Source

Chay et al. (2022) "Coordination of care by breeders and helpers in the
cooperatively breeding long-tailed tit, Aegithalos caudatus". Data
available at Dryad:
https://datadryad.org/dataset/doi:10.5061/dryad.mkkwh712k
