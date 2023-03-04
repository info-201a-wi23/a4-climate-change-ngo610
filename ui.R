# Define UI for application
library("shinythemes")
library(shiny)
library("dplyr")
library("ggplot2")
library("plotly")
library("rsconnect")
library("plotly")
library("rsconnect")
library(tidyverse)

# Load data
climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

climate_df <- climate_df %>% 
  filter(year > 1999, na.rm = TRUE)

subset_df <- climate_df %>%
  filter(year > 1999) %>% 
  group_by(country) %>% 
  select(country, year, population, cement_co2_per_capita, co2_per_capita, flaring_co2_per_capita,
         gas_co2_per_capita, ghg_per_capita, methane_per_capita, nitrous_oxide_per_capita, 
         oil_co2_per_capita)

# User Interface
intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    h1("Introduction"),
    p("Carbon Dioxide (CO2) is a greenhouse gas produced by the burning of fossil fuels"),
    a(href = "https://gist.github.com/4211337", "Source code"),
    h1("The Dataset"),
    h1("Calculated Variables"),
    h1("Insights")
   ),
)

select_widget <- 
  selectInput(
    inputId = "country_selection",
    label = "Country",
    choices = subset_df$country,
    selectize = TRUE,
    multiple = TRUE,
    selected = "Afghanistan"
  )

slider_widget <- sliderInput(
  inputId = "year_selection",
  label = "Year",
  min = 2000,
  max = 2020,
  value = c(2000, 2020),
  sep = ""
)

main_panel_plot <- mainPanel(
    plotlyOutput(outputId = "climate_plot"),
    h1("Insights"),
    p("This bar chart highlights the comparison of total carbon dioxide emissions between different countries as selected with the widgets on the left panel. In addition, for each country, the numbers are broken down by year, as also selected with a widget, and the population of each country during that year is displayed. We can use this chart to find which countries have the highest CO2 emissions as measured in million tonnes."),
    p("High population tends to correlate with higher levels of CO2 emissions. There doesn't appear to be a clear pattern between the year and the million tonnes of emissions, however, this may be dependent on the specific countries. The country with the record highest highest CO2 emissions was the United States in 2005 with 6137.604 million tonnes.")
)

plot_tab <- tabPanel(
  "Data Visualization",
  fluidPage(
    h1("Bar Chart Visualization")
    ),
  sidebarLayout(
  sidebarPanel(
    select_widget,
    slider_widget
  ),
  main_panel_plot
))
  
  
my_ui <- navbarPage(
  theme = shinytheme("sandstone"),
  "A4: Climate Change",
  intro_tab,
  plot_tab
)