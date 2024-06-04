weather$date <- as.Date(weather$date, format = "%m/%d/%Y")
trips$start_date <- as.Date(trip$start_date, format = "%m/%d/%Y")

get_season <- function(date) {
  month <- as.integer(format(date, "%m"))
  if (month %in% c(3, 4, 5)) {
    "Printemps"
  } else if (month %in% c(6, 7, 8)) {
    "Été"
  } else if (month %in% c(9, 10, 11)) {
    "Automne"
  } else {
    "Hiver"
  }
}


weather_and_trips <- left_join(weather, trips, by = c("date" = "start_date"), relationship = "many-to-many")



#Trajets de moins de 4h
weather_and_trips <- weather_and_trips %>% select(id, date, duration) %>% filter(duration<60*60*4)


# Ajouter une colonne 'Saison'
weather_and_trips <- weather_and_trips %>%
  mutate(Saison = sapply(date, get_season))

# Convert seconds to minutes
weather_and_trips <- weather_and_trips %>%
  mutate(duration_in_minutes = duration / 60)  

write_csv(weather_and_trips, "../data/weather_and_trips.csv")
