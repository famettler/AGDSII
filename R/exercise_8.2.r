# I will use the phenocamr package which
# interfaces with the phenocam network API
# to download time series of vegetation
# greenness and derived phenology metrics
library(phenocamr)

# download greenness time series,
# calculate phenology (phenophases),
# amend with DAYMET data

if (FALSE) { # if you want to keep this way, delete the if for-loop, if not, download it and store it and then use the way below. later you will need to download it because it takes alot of time
  phenocamr::download_phenocam(
    site = "harvard$",
    veg_type = "DB",
    roi_id = "1000",
    daymet = TRUE,
    phenophase = TRUE,
    trim = 2022,
    out_dir = tempdir()
  )
}

harvard_phenocam_data <- readr::read_csv(
  file.path(tempdir(), "harvard_DB_1000_3day.csv"),
  comment = "#"
)

# reading in harvard phenology only retaining
# spring (rising) phenology for the GCC 90th
# percentile time series (the default)
harvard_phenology <- readr::read_csv(
  file.path(
    tempdir(),
    "harvard_DB_1000_3day_transition_dates.csv"
  ),
  comment = "#"
) |>
  dplyr::filter(
    direction == "rising",
    gcc_value == "gcc_90"
  )
