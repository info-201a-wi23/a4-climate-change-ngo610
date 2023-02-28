# Load data
climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# Sort by USA
usa_climate_df <- climate_df %>% 
  filter(country == "United States")
