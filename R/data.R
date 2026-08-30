#' A field experiment assessing the roles of drought, herbivory, and local climate for white clovers
#'
#' This dataset contains data from a field experiment conducted by Albano et al. (2026) to assess the roles of drought, herbivory, and local climate on white clovers (Trifolium repens). The experiment was designed to investigate how these factors influence the growth, survival, and reproductive success of white clovers in different environmental conditions.
#'
#' * Garden: Location or site where the plants are grown (e.g., Ontario).
#' * WholePlotID: Identifier for the whole plot or main experimental block.
#' * SplitPlotID: Identifier for a smaller sub-division within the whole plot.
#' * PlantID: Unique identifier for each plant.
#' * Cyanotype: Plant type based on cyanogenesis (whether the plant produces cyanogenic compounds). Values like AcLi, Acli, etc., indicate different cyanotype genotypes.
#' * Cyanogenesis: Whether the plant is cyanogenic or not (produces cyanide compounds) — e.g., Cyanogenic or Acyanogenic.
#' * Ac_ac and Li_li: Specific alleles/genetic markers related to cyanogenesis genes. Different capitalization indicates allele variants.
#' * Precipitation: Experimental treatment for water — e.g., reduced or controlled precipitation.
#' * Herbivores: Herbivory pressure treatment — e.g., reduced or Control (normal) herbivore presence.
#' * Survived21: Binary (0/1) indicating whether the plant survived in year 21.
#' * Flowered21: Binary (0/1) indicating whether the plant flowered in year 21.
#' * Seeded21: Binary (0/1) indicating whether the plant produced seeds in year 21.
#' * FlowerHeadNumber21: Number of flower heads produced by the plant in year 21.
#' * SeedSetMass21: Mass (likely grams or mg) of seeds set in year 21.
#' * MaxArea21: Maximum area (likely leaf or plant canopy area) measured in year 21.
#' * GrowthRate21: Growth rate of the plant during year 21 (units unclear, possibly relative or absolute growth).
#' * Herbivory21: Measure of herbivore damage or intensity on the plant in year 21.
#' * SurvivedWinter: Binary (0/1) indicating whether the plant survived over the winter period.
#' * Survived22: Binary (0/1) indicating survival during year 22.
#' * Flowered22: Binary (0/1) indicating flowering status in year 22.
#' * Seeded22: Binary (0/1) indicating seed production in year 22.
#' * FlowerHeadNumber22: Number of flower heads produced in year 22.
#' * SeedSetMass22: Mass of seeds set in year 22.
#' * MaxArea22: Maximum area measured in year 22.
#' * GrowthRate22: Growth rate during year 22.
#' * Herbivory22: Herbivore damage measure during year 22.
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
#' * `brood_size`: The number of days, since recorded hatching, that a watch was performed
#' * `carer_number`: The number of carers observed provisioning during a given watch
#' * `watch_duration`: The time, in minutes, between the first and last recorded feed during a given watch
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
