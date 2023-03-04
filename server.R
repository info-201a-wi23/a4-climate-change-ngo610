library(shiny)
library("dplyr")
library("ggplot2")
library("plotly")
library("rsconnect")
library("plotly")
library("rsconnect")
library(tidyverse)

# Define server for application

# Load data
climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# Create dataframe
subset_df <- climate_df %>%
  filter(year > 1999, na.rm = TRUE) %>%
  group_by(country) %>%
  select(country, year, population, co2)
subset_df <- subset_df %>% drop_na()

# Create dataframe to calculate highest total CO2 stats
highest_co2 <- subset_df %>%
  filter(!country %in% c("World", "Asia", "Europe", "North America", "South America", "Africa", "Lower-middle-income countries", "Upper-middle-income countries", "High-income countries", "Low-income countries", "Middle-income countries")) %>%
  group_by(country) %>%
  filter(co2 == max(co2, na.rm = TRUE)) %>%
  arrange(desc(co2)) %>%
  head(n = 1)

# Pull the country with the highest CO2 emissions
highest_co2_country <- highest_co2 %>%
  pull(country)

# Pull the year with the highest CO2 emissions
highest_co2_year <- highest_co2 %>%
  pull(year)

# Pull the CO2 emission number
highest_co2_co2 <- highest_co2 %>%
  pull(co2)

# Create continents dataframe
continent_total <- subset_df %>%
  filter(country %in% c("Africa", "Asia", "Europe", "North America", "South America", "Australia")) %>%
  group_by(country) %>%
  summarize(total_co2 = sum(co2))

# Find average CO2 emissions per continent
avg_co2_continent <- continent_total %>%
  summarize("average" = mean(total_co2)) %>%
  pull(average)

# Find total CO2 emissions across every year for each continent
highest_co2_continent <- continent_total %>%
  filter(total_co2 == max(total_co2)) %>%
  pull(country)

# Create year dataframe
year_co2 <- subset_df %>%
  filter(!country %in% c("World", "Asia", "Europe", "North America", "South America", "Africa", "Lower-middle-income countries", "Upper-middle-income countries", "High-income countries", "Low-income countries", "Middle-income countries")) %>%
  group_by(year) %>%
  summarize(total_co2 = sum(co2)) %>%
  filter(total_co2 == max(total_co2)) %>%
  pull(year)

# Create dataframe comparing high and low income countries
income_comparison <- subset_df %>%
  filter(country %in% c("High-income countries", "Low-income countries")) %>%
  filter(year == 2020) %>%
  pull(co2)

# Calculate difference between high and low income countries
income_comparison <- 11939 - 192

# Server
my_server <- function(input, output) {
  output$climate_plot <- renderPlotly({
    # Create filtered dataframe
    selected_df <- subset_df %>%
      # Filter for selected country
      filter(country %in% input$country_selection) %>%
      # Filter for year between 2000-2022
      filter(year > input$year_selection[1] & year < input$year_selection[2])

    climate_plot <- ggplot(data = selected_df) +
      geom_col(mapping = aes(
        x = co2,
        y = country,
        text = paste(
          "</br> CO2: ", co2,
          "</br> Year: ", year,
          "</br> Population: ", population
        ),
        fill = country
      )) +
      scale_color_brewer(palette = "Paired") +
      labs(
        title = "Total Production-Based Emissions of CO2",
        x = "CO2 Emissions (Measured in Million Tonnes)",
        y = "Country"
      ) +
      theme(
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(color = "black")
      )
    return(ggplotly(climate_plot, tooltip = "text"))
  })
}
