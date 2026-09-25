#' A field experiment assessing the roles of drought, herbivory, and local climate for white clovers
#'
#' This dataset contains data from a field experiment conducted by Albano et al. (2026) to assess the roles of drought, herbivory, and local climate on white clovers (Trifolium repens). The experiment was designed to investigate how these factors influence the growth, survival, and reproductive success of white clovers in different environmental conditions.
#'
#' * Garden: Location of the experimental site (Ontario or Louisiana).
#' * WholePlotID: Identifier of the whole plot, each containing 8 plants (numbered 1 to 48).
#' * SplitPlotID: Identifier of the split plot within each whole plot, each containing 4 plants (numbered 1 or 2).
#' * PlantID: Identifier of the plant within each split plot (numbered 1 to 4).
#' * Cyanotype: One of four phenotypes (AcLi, Acli, acLi or acli) based on the presence or absence of a dominant allele at each of the two loci (Ac/ac and Li/li) underlying hydrogen cyanide (HCN) production.
#' * Cyanogenesis: Whether the plant can produce HCN: Cyanogenic (AcLi) or Acyanogenic (Acli, acLi or acli).
#' * Ac_ac: Whether the plant has at least one dominant allele at the Ac/ac locus (Ac = yes, ac = no).
#' * Li_li: Whether the plant has at least one dominant allele at the Li/li locus (Li = yes, li = no).
#' * Precipitation: Precipitation reduction treatment (Control or Reduced).
#' * Herbivores: Herbivore reduction treatment (Control or Reduced).
#' * Survived21: Whether the plant survived the first growing season (2021); 1 = yes, 0 = no.
#' * Flowered21: Whether the plant flowered in the first growing season (2021); 1 = yes, 0 = no.
#' * Seeded21: Whether the plant produced seeds in the first growing season (2021); 1 = yes, 0 = no.
#' * FlowerHeadNumber21: Total number of flower heads produced by the plant in the first growing season (2021).
#' * SeedSetMass21: Total seed set mass (in grams) from the flower heads collected from the plant in the first growing season (2021).
#' * MaxArea21: Maximum lateral area (in cm^2) taken up by the plant across the monthly measurements of the first growing season (2021).
#' * GrowthRate21: Growth rate of the plant during the first growing season (2021), calculated as ln(maximum lateral area) minus ln(initial lateral area), divided by the number of days between these measurements.
#' * Herbivory21: Percentage of leaf area consumed by herbivores, averaged across 5 trifoliate leaves per plant, in July of the first growing season (2021).
#' * SurvivedWinter: Whether the plant survived the winter between the 2021 and 2022 growing seasons; 1 = yes, 0 = no. This is NA for all plants in Louisiana and for plants in Ontario that died during the 2021 growing season.
#' * Survived22: Whether the plant survived the second growing season (2022); 1 = yes, 0 = no.
#' * Flowered22: Whether the plant flowered in the second growing season (2022); 1 = yes, 0 = no.
#' * Seeded22: Whether the plant produced seeds in the second growing season (2022); 1 = yes, 0 = no.
#' * FlowerHeadNumber22: Total number of flower heads produced by the plant in the second growing season (2022).
#' * SeedSetMass22: Total seed set mass (in grams) from the flower heads collected from the plant in the second growing season (2022).
#' * MaxArea22: Maximum lateral area (in cm^2) taken up by the plant across the monthly measurements of the second growing season (2022).
#' * GrowthRate22: Growth rate of the plant during the second growing season (2022), calculated in the same way as GrowthRate21.
#' * Herbivory22: Percentage of leaf area consumed by herbivores, averaged across 5 trifoliate leaves per plant, in the second growing season (2022).
#'
#' Missing values (NA) in the 2021 and 2022 measurements represent plants for which data could not be collected, or, for 2022, plants that had already died.
#'
#' @source Albano et al. (2026) "Data from: A field experiment assessing the roles of drought, herbivory, and local climate on cyanogenesis cline formation and local adaptation in Trifolium repens". Data available at Dryad: https://datadryad.org/dataset/doi%3A10.5061/dryad.4xgxd25n1
#'
"white_clover"


#' Coordination of care by breeders and helpers in the cooperatively breeding long-tailed tit
#'
#' * `id`: Unique identifier for each provisioning watch
#' * `feeds`: Number of feeds by each individual per watch
#' * `data_type`: Whether the data was taken directly from field observation (observed) or from null model randomization (expected)
#' * `alt_feeds`: Number of alternated visits
#' * `percent_alt`: Percentage of each carer's visits which were alternated
#' * `sync_feeds`: Number of synchronized visits (2-minute interval)
#' * `percent_sync2mins`: Percentage of each carer's visits which were synchronized (2-minute interval)
#' * `carer_status`: Factor designating whether a carer was a breeding female (female), breeding male (male) or non-breeding helper (helper)
#' * `carer_id`: The unique identifier for each carer
#' * `total_feed_rate`: The number of feeds performed by all carers per hour
#' * `brood_size`: The number of chicks in the brood
#' * `carer_number`: The number of carers observed provisioning during a given watch
#' * `watch_duration_mins`: The time, in minutes, between the first and last recorded feed during a given watch
#' * `watch_time`: Number of hours since the start of the day 00:00 the watch was started
#' * `brood_age`: The number of days, since recorded hatching, that a watch was performed
#' * `julian_hatch_date`: The number of days since March 1 each year that the eggs hatched
#' * `a_max`: The total percentage of visits during a given watch which could theoretically be alternated (or synchronized). Formula as follows: 100 - ((Number of feeds by highest feed rate carer - Number of feeds by all remaining carers)/Total number of feeds)*100
#' * `year`: Unique identifier for each year the watch was performed during
#' * `nest`: Unique identifier for each nest
#' * `individual_feed_rate`: The number of feeds performed by each carer per hour
#' * `row_ref`: Row reference 1-7950
#'
#' @source Chay et al. (2022) "Coordination of care by breeders and helpers in the cooperatively breeding long-tailed tit, Aegithalos caudatus". Data available at Dryad: https://datadryad.org/dataset/doi:10.5061/dryad.mkkwh712k
"watch_tits"
