
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Interactive map demo - Australian Census 2016"),
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(6,
           h3("Proportion of adults with year 10 or lower education"),
           leafletOutput("map")
    ),
    
    column(6,
           h3("More detailed breakdown by age and education"),
           ggvisOutput("barchart"))
  ),
  fluidRow(
    HTML("<div><p>This app is a minimal example of interactivity between a choropleth leaflet map with a ggvis chart.
       Source code is <a href = 'https://github.com/ellisp/int-map-demo'>on GitHub</a>.</p></div>")
  )
  )
)

