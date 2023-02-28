# Define server for application

# Load data
climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

usa_climate_df <- climate_df %>% 
  filter(country == "United States")

# Server
my_server <- function(input, output) { 
  output$distplot <- renderPlotly({
    selected_df <- climate_df %>% 
      filter(year > 1999) %>% 
      filter(country %in% input$user_selection)

  
  distplot <- ggplot(data = selected_df) + 
    geom_col(mapping = aes(
      x = co2,
      y = reorder(country, -co2),
      text = paste('</br> Year: ', year,
                   '</br> CO2: ', co2),
      fill = country) 
    ) +
    labs(title = "Climate Change in 21st Century", 
         x = "Population", 
         y = "Year") # Check A3
  return(ggplotly(distplot, tooltip = "text"))
  
  })
}

