# ui.R

library(shiny)
library(shinydashboard)
library(leaflet)

dashboardPage(
  dashboardHeader(title = "Visualisation des trajets en vélo à San Francisco"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Cartes", tabName = "cartes", icon = icon("map")),
      menuItem("Météo", tabName = "meteo", icon = icon("cloud"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "cartes",
              fluidRow(
                box(
                  title = "Options",
                  status = "primary",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  selectInput("start_station", "Station de départ", choices = NULL),
                  selectInput("end_station", "Station d'arrivée", choices = NULL),
                  #checkboxInput("show_all", "Afficher tous les trajets", value = FALSE)
                ),
                infoBoxOutput("average_duration_box", width = 6)
              ),
              fluidRow(
                box(
                  width = 12,
                  leafletOutput("map"),
                 
                )
              )
      ),
      tabItem(tabName = "meteo",
              fluidRow(
                box(
                  title = "Trajets en fonction de la météo",
                  status = "primary",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  # Placeholder for weather content
                  selectInput("graphique_meteo", "Sélectionner le type de valeurs", choices = c("Nombre de trajets", "Durée moyenne des trajets")),
                  plotOutput("graphique_meteo")
                ),
                
                box(
                  title = "Trajets en fonction de la saison",
                  status = "primary",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  # Placeholder for weather content
                  selectInput("graphique_saison", "Sélectionner le type de valeurs", choices = c("Nombre de trajets", "Durée moyenne des trajets")),
                  plotOutput("graphique_saison")
                )
              )
      )
    )
  )
)
