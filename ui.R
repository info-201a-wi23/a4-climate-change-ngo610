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

# User Interface
intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    h1("Introduction"),
    "Carbon Dioxide (CO2) is a greenhouse gas produced by the burning of fossil fuels and wildfires, and while it's one of the most important heat trapping gases, at the rate humans have been adding more carbon dioxide to the atmosphere, global temperature is rising as a result. In the last 200 years, the carbon dioxide content in the atmosphere has raised by 50%",
    a(href = "https://climate.nasa.gov/vital-signs/carbon-dioxide/#:~:text=Carbon%20dioxide%20in%20the%20atmosphere,in%20less%20than%20200%20years.", "(Source: NASA)"),
    "This project analyzes the differences in total carbon dioxide emissions between different countries, looking for comparisons in relation to year and population in order to find those patterns.",
    h1("The Dataset"),
    "The data used in this report is provided by",
    a(href = "https://ourworldindata.org/co2-and-greenhouse-gas-emissions", "Our World in Data"),
    "who gathered statistics around CO2 and greenhouse gas emissions across 207 countries, creating a dataset by building off of a variety of pre-existing datasets. A list of these can be found",
    a(href = "https://github.com/owid/co2-data", "here."),
    "Our World in Data collects data and makes it available to the world in order to build understanding about current and relevant issues. It's important to note that this dataset is lacking in complete information. Between the wide scope of years that it covers, there are thousands of NA values across all 75 parameters. The earliest data is from 1850, and there are very few measurements for different values, especially depending on the country. Different countries have data available all the way back until 1850 while for other countries, consistent data wasn't recorded until much later. It's impossible to use this data to make a completely full comparison between these countries over the span of the entire recording of the data.",
    h1("Calculated Variables"),
    h4("This report looks at total carbon dioxide emissions across 2000 to 2021, specifically answering:"),
    "What is the country with the highest total carbon dioxide emission recorded in a year?",
    strong("China"),
    br(),
    "How much carbon dioxide was admitted by this country?",
    strong("11472.368 million tonnes"),
    br(),
    "What year was this?",
    strong("2021"),
    br(),
    "Which continent has the highest total carbon dioxide emission from 2000-2021?",
    strong("Asia"),
    br(),
    "What is the average total carbon dioxide emission across every continent from 2000-2021?",
    strong("115418.617 million tonnes"),
    br(),
    "Which year had the highest total carbon dioxide emission across the entire world?",
    strong("2021"),
    br(),
    "What is the difference between the highest total carbon dioxide emission for high-income countries in 2021 versus low-income countries?",
    strong("11747 million tonnes"),
    br(),
    h1("Conclusion"),
    "The data visualization in this report shows the drastic differences in total carbon dioxide emissions between different countries. As the years go on, carbon dioxide emission numbers only increase, and the temperature on the Earth continues to rise alongside it. While Asia produces the most CO2 emissions per most years, it's important to note that the United States also contributes a ton of carbon dioxide emission to the atmosphere, and this problem will only get worse in the coming years.",
    br()
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
  p("High population tends to correlate with higher levels of CO2 emissions. There doesn't appear to be a clear pattern between the year and the million tonnes of emissions, however, this may be dependent on the specific countries. The country with the record highest highest CO2 emissions was the China in 2021 with 11472.368 million tonnes.")
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
  )
)


my_ui <- navbarPage(
  theme = shinytheme("sandstone"),
  "A4: Climate Change",
  intro_tab,
  plot_tab
)
