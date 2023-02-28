# install.packages("shiny")
library(shiny)
source("ui.R")
source("server.R")
library("dplyr")
library("ggplot2")
library("plotly")
library("rsconnect")

# Runs the application (both ui and server)
shinyApp(ui = my_ui, server = my_server)

# Analyze total co2 emission for US across years
# Add Canada?