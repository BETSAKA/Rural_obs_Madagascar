
# Load librairies
library(tidyverse)    # A series of packages for data manipulation
library(haven)        # Required for reading STATA files (.dta)
library(labelled)     # To work with labelled data from STATA
library(sf)           # for spatial data handling
library(tidyverse)    # for data wrangling and visualization
library(stringdist)   # for string distance and matching
library(tmap)         # for mapping
library(fuzzyjoin)    # for fuzzy joining
library(readxl)       # Read data frames to Excel format
library(writexl)      # Write data frames to Excel format
library(gt)           # for nicely formatted tables
library(cowplot)      # to combine plots
library(gtsummary)    # to produce nice summary tables
library(janitor)      # to simply add rowsums

# Load existing observatories
obs_communes <- st_read(
  "data/observatoires/Observatoires_ROR_communes_COD.gpkg",
  quiet = TRUE) %>%
  select(-OBS_Y_N, -OBS_NAME)

# Load georeferenced data
ref_communes <- read_xlsx("data/observatoires/Obs_Communes_2.xlsx") %>%
  select(ADM3_PCODE, OBS_Y_N, OBS_NAME, SOURCE_OBS) %>%
  mutate(OBS_NAME = case_when(
    OBS_NAME == "Itasy (ex-Soavinandriana)" ~ "Itasy",
    OBS_NAME == "Belo/Tsiribihy" ~ "Menabe-Belo",
    OBS_NAME == "Fianarantsoa-Saha" ~ "Fianarantsoa",
    OBS_NAME == "Ihosy (Ihorombe)" ~ "Ihosy",
    .default = OBS_NAME))

obs_communes2 <- obs_communes %>%
  left_join(ref_communes, by = "ADM3_PCODE")

# st_write(obs_communes2,
#          "data/observatoires/Observatoires_ROR_communes_COD_v2.gpkg")

Vahatra <- st_read("../Aires protégées/Vahatra/Shapefiles/AP_Vahatra.shp", 
                   quiet = TRUE) %>%
  st_make_valid() %>%
  mutate(label = "Protected area__")

obs_communes2 %>%
  filter(!is.na(OBS_NAME)) %>%
  tm_shape() +
  tm_polygons(col = "OBS_NAME") +
  tm_shape(Vahatra) +
  tm_fill(col = "darkgreen", alpha = 0.3)


""
"Tsimanampesotsa"
