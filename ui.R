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
  "Introduction"
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
# 
# plot_tab <- tabPanel(
#   "Visualzation",
#   fluidPage(
#     h1("Bar Chart Visualization")
#   )
# )

main_panel_plot <- mainPanel(
    plotlyOutput(outputId = "climate_plot"),
)

plot_tab <- tabPanel(
  "Data Visualization",
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