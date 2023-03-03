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

climate_df <- climate_df %>% 
  filter(year > 1999, na.rm = TRUE)

subset_df <- climate_df %>%
  group_by(country) %>% 
  select(country, year, co2)

subset_df <- subset_df %>% drop_na()

# Compare 
# cemest_co2_per_capita
# co2_per_capita
# flaring_co2_per_capita
# gas_co2_per_capita
# ghg_per_capita
# methane_per_capita
# nitrous_oxide_per_capita
# oil_per_capita

# usa_climate_df <- climate_df %>% 
#   filter(country == "United States")

# Server
my_server <- function(input, output) { 
  
  output$climate_plot <- renderPlotly({
  
  # Create filtered dataframe  
  selected_df <- subset_df %>% 
  # Filter for selected country
  filter(country %in% input$country_selection) %>% 
  # Filter for year between 2000-2022
  filter(year > input$year_selection[1] & year < input$year_selection[2])
  
  # climate_plot <- ggplot(data = selected_df) + 
  #   geom_col(mapping = aes(
  #     x = c(cement_co2_per_capita, co2_per_capita, flaring_co2_per_capita,
  #           gas_co2_per_capita, ghg_per_capita, methane_per_capita, nitrous_oxide_per_capita, 
  #           oil_co2_per_capita),
  #     y = reorder(country),
  #     text = paste('</br> Year: ', year,
  #                  '</br> Population: ', population),
  #     fill = country) 
  #   ) +
  #   labs(title = "Climate Change in 21st Century", 
  #        x = "CO2 Per Capita", 
  #        y = "Country") # Check A3
  
  climate_plot <- ggplot(data = selected_df) +
    geom_col(mapping = aes(
      x = co2,
      y = country,
      text = paste('</br> CO2: ', co2,
                   '</br> Year: ', year),
      fill = country)) +
    scale_color_brewer(palette = "Paired") +
    labs(title = "Total Production-Based Emissions of CO2 in Different Countries from 2000-2022",
         x = "CO2 Emissions (Measured in Million Tonnes)",
         y = "Country") +
    theme(legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(), axis.line = element_line(color = "black"))
  return(ggplotly(climate_plot, tooltip = "text"))

  # climate_plot <- ggplot(data = selected_df) + 
  #   geom_col(mapping = aes(
  #             x = reorder(country, -population),
  #             y = cement_co2_per_capita,
  #             fill = country))
  # 
  # ggplotly(climate_plot, tooltip = "text")
  
  })
}

