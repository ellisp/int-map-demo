
# example at http://shiny.rstudio.com/gallery/superzip-example.html is pretty complex...

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
   
  pal_fun <- colorNumeric("Blues", NULL, n = 5)
  sa4_popup <- with(school_sa4_map, paste0(sa4_name_2016, ": ",
                                           round(prop_yr10_below * 100), "%"))
  
  output$map <- renderLeaflet({
    
    leaflet(school_sa4_map) %>%
      addPolygons(fillColor = ~pal_fun(prop_yr10_below),
                  fillOpacity = 1,
                  layerId = ~sa4_name_2016,
                  stroke = TRUE,
                  color = "grey20",
                  label = sa4_popup
      ) %>%
      addLegend(pal = pal_fun,
                values = ~prop_yr10_below,
                opacity = 1,
                title = "Below year 10")
                  
    })
  
  clicked <- reactive({
    id = input$map_shape_click$id
    if(!is.null(id)){
      the_data <- school_sa4 %>%
        dplyr::filter(SA4_NAME16 == id) 
    } else {
      the_data <- school_sa4 %>%
        group_by(MaxSchoolingCompleted, Age) %>%
        summarise(adults = sum(adults)) %>%
        ungroup()
    }
    return(the_data)
  })
  
  
    clicked %>%
      ggvis(fill = ~MaxSchoolingCompleted, y = ~adults, x = ~Age) %>%
      layer_bars(stroke := NA) %>%
      scale_ordinal("fill", range = brewer.pal(9, "Spectral")) %>%
      add_axis("y", title = "Number of adults", title_offset = 75) %>%
      add_legend("fill", 
                 title = "Maximum school completed",
                 values = rev(levels(school_sa4$MaxSchoolingCompleted))) %>%
    bind_shiny("barchart")

  
})
