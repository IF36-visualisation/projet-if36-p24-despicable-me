library(shiny)
library(dplyr)
library(readr)
library(leaflet)
library(leaflet.extras)
library(shinydashboard)

# Lire les données des fichiers CSV
trips <- read_csv("trip.csv")
stations <- read_csv("station.csv")

# Convertir les durées de trajets de secondes en minutes
trips <- trips %>%
  mutate(duration = duration / 60)

# Filtrer les trajets pour supprimer ceux supérieurs à 4 heures (240 minutes)
trips <- trips %>%
  filter(duration <= 240)

# Calculer la durée moyenne des trajets entre chaque paire de stations aller-retour
average_durations <- trips %>%
  group_by(start_station_id, end_station_id) %>%
  summarize(average_duration = mean(duration)) %>%
  ungroup()

# Fusionner les données des stations pour obtenir les coordonnées
average_durations <- average_durations %>%
  left_join(stations, by = c("start_station_id" = "id")) %>%
  rename(start_station_name = name, start_lat = lat, start_long = long) %>%
  left_join(stations, by = c("end_station_id" = "id")) %>%
  rename(end_station_name = name, end_lat = lat, end_long = long)

# Fonction pour obtenir une couleur basée sur la durée
get_color <- function(duration, max_duration) {
  palette <- colorRampPalette(c("green", "yellow", "red"))
  colors <- palette(100)
  index <- floor((duration / max_duration) * 99) + 1
  colors[index]
}

shinyServer(function(input, output, session) {
  # Mettre à jour les choix des sélecteurs
  updateSelectInput(session, "start_station", choices = stations$name)
  updateSelectInput(session, "end_station", choices = stations$name)
  
  # Filtrer les trajets selon les sélections
  filtered_data <- reactive({
    req(input$start_station, input$end_station)
    start_id <- stations %>% filter(name == input$start_station) %>% pull(id)
    end_id <- stations %>% filter(name == input$end_station) %>% pull(id)
    average_durations %>%
      filter(start_station_id == start_id & end_station_id == end_id)
  })
  
  # Créer la carte
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(data = stations, ~long, ~lat, popup = ~name, radius = 5, color = "blue", fill = TRUE)
  })
  
  # Mettre à jour la carte avec le trajet sélectionné ou tous les trajets
  observe({
    leafletProxy("map") %>%
      clearMarkers() %>%
      clearShapes()
    
    max_duration <- max(average_durations$average_duration)
    
 # if (input$show_all) {
    if (0==1) {
  #    all_data <- average_durations
  #    for (i in 1:nrow(all_data)) {
  #     color <- get_color(all_data$average_duration[i], max_duration)
  #     leafletProxy("map") %>%
  #        addPolylines(
  #          lng = c(all_data$start_long[i], all_data$end_long[i]),
  #          lat = c(all_data$start_lat[i], all_data$end_lat[i]),
  #          color = color,
  #          weight = 10,
  #         popup = paste0("De: ", all_data$start_station_name[i], "<br>A: ", all_data$end_station_name[i], "<br>Durée moyenne de ce trajet: ", round(all_data$average_duration[i], 2), " minutes")
  #       ) %>%
  #        addAwesomeMarkers(
  #          lng = all_data$start_long[i],
  #          lat = all_data$start_lat[i],
  #          icon = awesomeIcons(
  #            icon = 'arrow-up',
  #           markerColor = 'blue'
  #         ),
  #          popup = paste0("Départ: ", all_data$start_station_name[i])
  #        ) %>%
  #       addAwesomeMarkers(
  #         lng = all_data$end_long[i],
  #         lat = all_data$end_lat[i],
  #          icon = awesomeIcons(
  #            icon = 'arrow-down',
  #            markerColor = 'red'
  #          ),
  #          popup = paste0("Arrivée: ", all_data$end_station_name[i])
 #         )
   #}
    } else {
      data <- filtered_data()
      if (nrow(data) > 0) {
        color <- get_color(data$average_duration, max_duration)
        leafletProxy("map") %>%
          addPolylines(
            lng = c(data$start_long, data$end_long),
            lat = c(data$start_lat, data$end_lat),
            color = color,
            weight = 10,
            popup = paste0("De: ", data$start_station_name, "<br>A: ", data$end_station_name, "<br>Durée moyenne: ", round(data$average_duration, 2), " minutes")
          ) %>%
          addAwesomeMarkers(
            lng = data$start_long,
            lat = data$start_lat,
            icon = awesomeIcons(
              icon = 'arrow-up',
              markerColor = 'blue'
            ),
            popup = paste0("Départ: ", data$start_station_name)
          ) %>%
          addAwesomeMarkers(
            lng = data$end_long,
            lat = data$end_lat,
            icon = awesomeIcons(
              icon = 'arrow-down',
              markerColor = 'red'
            ),
            popup = paste0("Arrivée: ", data$end_station_name)
          )
        
        # Mettre à jour la durée moyenne du trajet
        output$average_duration_box <- renderInfoBox({
          infoBox(
            "Durée moyenne",
            paste(round(data$average_duration, 2), " minutes"),
            icon = icon("clock"),
            color = "blue"
          )
        })
      } else {
        output$average_duration_box <- renderInfoBox({
          infoBox(
            "Durée moyenne",
            "Aucun trajet sélectionné.",
            icon = icon("clock"),
            color = "blue"
          )
        })
      }
    }
  })
})
