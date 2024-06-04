library(shiny)
library(dplyr)
library(readr)
library(leaflet)
library(leaflet.extras)
library(shinydashboard)
library(tibble)
library(tidyr)
library(ggplot2)
library(lubridate)

# Lire les données des fichiers CSV
trips <- read_csv("../data/trip.csv")
stations <- read_csv("../data/station.csv")
weather <- read_csv("../data/weather.csv")

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


#---------------------PARTIE METEO-----------------------------------------------------------------------
# Pour manipuler facilement les dates et les heures

# Supposons que vos dataframes sont df_trip et df_weather
# Vous pouvez les lire à partir de fichiers CSV par exemple

df_trip <- read_csv("../data/trip.csv")
df_weather <- read_csv("../data/weather.csv")

# Convertir les colonnes de date en format Date
# Extraire la date de start_date dans df_trip
df_trip$start_date <- mdy_hm(df_trip$start_date)
df_trip$date <- as.Date(df_trip$start_date)

# Convertir la colonne date dans df_weather en format Date si ce n'est pas déjà fait
df_weather$date <- mdy(df_weather$date)

# Fusionner les dataframes sur zip_code et date
df_merged <- merge(df_trip, df_weather, by = c("zip_code", "date"))

# Convertir les valeurs de la colonne 'events' en minuscules
df_merged$events <- tolower(df_merged$events)

# Remplacer les valeurs NA dans la colonne 'events' par 'inconnu'
df_merged$events <- replace_na(df_merged$events, "Temps clair")

# Calculer la durée moyenne des trajets par événement météorologique
df_summary <- df_merged %>%
  group_by(events) %>%
  summarize(mean_duration = mean(duration, na.rm = TRUE))

# Convertir la durée moyenne des trajets de secondes en minutes
df_summary <- df_summary %>%
  mutate(mean_duration_minutes = mean_duration / 60)

# Trier les données par ordre croissant de la durée moyenne
df_summary <- df_summary %>%
  arrange(mean_duration_minutes)

# Définir les couleurs pour chaque événement météorologique
event_colors <- c("rain" = "#176df1", "fog" = "#a5bdba", "fog-rain" = "#8dd4dc", "rain-thunderstorm" = "#04a294", "Temps clair" = "#f0e807")

# Définir les nouvelles étiquettes pour les événements
event_labels <- c("rain" = "Pluie", "fog" = "Brouillard", "fog-rain" = "Brouillard et pluie", "rain-thunderstorm" = "Orage", "NA"="Temps clair")

# Créer le bar chart avec des couleurs personnalisées et des étiquettes renommées
graph_meteo_duree_moyenne <- ggplot(df_summary, aes(x = reorder(events, mean_duration_minutes), y = mean_duration_minutes, fill = events)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = event_colors, labels = event_labels) +
  scale_x_discrete(labels = event_labels) +
  labs(title = "Durée moyenne des trajets en fonction de la météo",
       x = "Événement météorologique",
       y = "Durée moyenne des trajets (minutes)",
       fill = "Météo") +
  theme_minimal()

df_summary <- df_merged %>%
  group_by(events) %>%
  summarize(trip_count = n())

df_summary <- df_summary %>%
  arrange(trip_count)

graph_meteo_nb_trajets <- ggplot(df_summary, aes(x = reorder(events, trip_count), y = trip_count, fill = events)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = event_colors, labels = event_labels) +
  scale_x_discrete(labels = event_labels) +
  labs(title = "Nombre de trajets en fonction de la météo",
       x = "Événement météorologique",
       y = "Nombre de trajets",
       fill = "Météo") +
  theme_minimal()


#---------------------FIN PARTIE METEO-----------------------------------------------------------------------

#---------------------PARTIE SAISON----------------------------------------------------------------
weather_and_trips <- read_csv("../data/weather_and_trips.csv")

graph_saison_nb_trajets <- ggplot(data = weather_and_trips, aes(x = Saison, fill = Saison)) +
  geom_bar(stat = "count", color = "black") +
  scale_fill_manual(values = c("Printemps" = "green", "Été" = "yellow", "Automne" = "orange", "Hiver" = "blue")) +
  labs(
    title = "Nombre de trajets par saisons",
    x = "Saisons",
    y = "Nombre de trajets"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  )


# Calculer la durée moyenne des trajets par saison
avg_duration_by_season <- weather_and_trips %>%
  group_by(Saison) %>%
  summarise(avg_duration = mean(duration_in_minutes))


# Créer le graphique
graph_saison_duree_moyenne <- ggplot(data = avg_duration_by_season, aes(x = Saison, y = avg_duration, fill = Saison)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_manual(values = c("Printemps" = "green", "Été" = "yellow", "Automne" = "orange", "Hiver" = "blue")) +
  labs(
    title = "Durée moyenne des trajets par saison",
    x = "Saisons",
    y = "Durée moyenne des trajets (minutes)"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  )




#---------------------FIN PARTIE SAISON----------------------------------------------------------------

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
  
  output$graphique_meteo <-renderPlot(
    {
      
      if (input$graphique_meteo == "Durée moyenne des trajets"){
        print(graph_meteo_duree_moyenne)
        
      }
      else if (input$graphique_meteo == "Nombre de trajets"){
        print(graph_meteo_nb_trajets)
      }
    }
  )
  
  output$graphique_saison <- renderPlot(
    if (input$graphique_saison == "Durée moyenne des trajets"){
      print(graph_saison_duree_moyenne)
    }
    else if (input$graphique_saison == "Nombre de trajets"){
      print(graph_saison_nb_trajets)
    }
  )
    
  })
  


