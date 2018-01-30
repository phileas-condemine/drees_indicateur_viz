library(shinydashboard)
library(leaflet)
library(dplyr)
library(curl) 
library(rgeos)





function(input, output, session) {
  
  # Route select input box
  output$indicateurSelect <- renderUI({
    indicateurs <- setdiff(names(indicateurs),"departement")
    
    
    selectInput("indName", "indicateur", choices = indicateurs, selected = indicateurs[1])
  })

  output$simplification <- renderUI({
    selectInput("simplify","% of point kept for simplification",choices=c("100","10","1"), selected = "10")
  })
  

  
  output$indicateurmap <- renderLeaflet({
    if (is.null(input$indName)|is.null(input$simplify))
      return()
    print("simplify")
    print(input$simplify)
    if(input$simplify=="100")
      dt=FRA_dep_list[[1]]
    else if(input$simplify=="10")
      dt=FRA_dep_list[[2]]
    else if(input$simplify=="1")
      dt=FRA_dep_list[[3]]
    #### ATTENTION A L'ORDRE DES @POLYGONES vs  @data QU'ON VA UTILISER POUR CONSTRUIRE LES LABELS, VERIFIER QUE LES NOMS SONT COHERENTS SUR LA CARTE
    dt@data=dt@data[order(dt@data$ID_2),]
    var=input$indName
    steps=quantile(dt@data[,var],0:8/8)
    pal <- colorBin("YlOrRd", domain = var,bins=steps)
    m<-leaflet(dt) %>% 
      addTiles() %>%
      setView(lng = 1.87528, lat = 46.60611, zoom = 6)
    print("var")
    print(var)
    
    labels <- sprintf(
      "<strong>%s</strong><br/>%g %s",
      dt@data$NAME_2, dt@data[,var],var
    ) %>% lapply(htmltools::HTML)
    mp<-m%>%  addPolygons(fillColor = as.formula(sprintf("~pal(%s)",var)),
                          weight = 1,
                          opacity = 1,
                          color = "white",
                          dashArray = "3",
                          fillOpacity = 0.7,
                          highlight = highlightOptions(
                            weight = 5,
                            color = "#666",
                            dashArray = "",
                            fillOpacity = 0.7,
                            bringToFront = TRUE)
                          , label=labels)
    mp
  })
}

