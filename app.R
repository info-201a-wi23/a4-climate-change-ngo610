# install.packages("shiny")
library(shiny)
library("dplyr")
library("ggplot2")
library("plotly")
library("rsconnect")
library("plotly")
library("rsconnect")
library(tidyverse)

source("ui.R")
source("server.R")
# Runs the application (both ui and server)
shinyApp(ui = my_ui, server = my_server)

# Select a year and country

# Compare 
# co2_per_capita
# flaring_co2_per_capita
# gas_co2_per_capita
# ghg_per_capita
# methane_per_capita
# nitrous_oxide_per_capita
# oil_per_capita