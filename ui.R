# Define UI for application

library(shiny)
library("dplyr")
library("ggplot2")
library("plotly")
library("rsconnect")

climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# User Interface
intro_panel <- tabPanel(
  "My page title"
)

plot_panel <- tabPanel(
  "My page title",
  sidebarPanel(
    sliderInput("bins",
                "Number of bins:",
                min = 1,
                max = 50,
                value = 30)
  ),
  
    mainPanel(
      plotlyOutput(outputId = "distplot"),
      selectInput(
        inputId = "user_selection",
        label = "Countries",
        choices = climate_df$country,
        selected = "Afganistan",
        multiple = TRUE
      )
    )
  
)

my_ui <- navbarPage(
  "My Title",
  intro_panel,
  plot_panel
)