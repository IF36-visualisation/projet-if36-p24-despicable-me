[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/Fj4cXJY4)
# Fichier à remplacer

# Analyse des Données du Service de Vélos en Libre-Service de la Baie de San Francisco

## Introduction

Ce projet vise à explorer et analyser les données du service de vélos en libre-service de la Baie de San Francisco, avec l'objectif de comprendre les facteurs influençant l'utilisation des vélos et d'identifier les tendances d'utilisation. Les données, provenant de Kaggle, incluent des informations détaillées sur les stations de vélo, la météo, le statut des vélos, et les trajets effectués.

## Données

### Source

Les données proviennent de [Kaggle](https://www.kaggle.com/datasets/benhamner/sf-bay-area-bike-share?select=trip.csv), et sont constituées de quatre fichiers CSV distincts : `Station`, `Weather`, `Status`, et `Trip`. 

### Description

- **Station** : 70 éléments avec 7 caractéristiques, telles que l'ID de la station, le nom, la latitude, la longitude, etc.
- **Weather** : 72M éléments avec 24 caractéristiques, incluant la date, la température maximale, moyenne, et minimale, l'humidité, etc.
- **Status** : 670 000 éléments avec 4 caractéristiques, telles que l'ID de la station, les vélos disponibles, etc.
- **Trip** : 3665 éléments avec 11 caractéristiques, y compris l'ID du trajet, la durée, la date de début, le nom de la station de départ, etc.

### Format

Chaque ensemble de données est formaté en CSV, facilitant l'importation et l'analyse dans divers outils d'analyse de données.

### Catégories et Sous-groupes

Les données sont divisées en quatre catégories principales correspondant aux aspects clés du service de vélos en libre-service, permettant une analyse multidimensionnelle de l'utilisation des vélos en fonction de la météo, de la disponibilité des vélos, et des préférences de trajet des utilisateurs.

### Caractéristiques des Données par Fichier

| Fichier  | Caractéristique                | Type        |
|----------|--------------------------------|-------------|
| **Station** | id                         | int         |
|          | name                       | str         |
|          | latitude                   | float       |
|          | longitude                  | float       |
|          | dock_count                 | int         |
|          | city                       | str         |
|          | installation_date          | date        |
| **Status**  | station_id                  | int         |
|          | bikes_available            | int         |
|          | docks_available            | int         |
|          | time                       | datetime    |
| **Trip**    | id                         | int         |
|          | duration                   | int         |
|          | start_date                 | datetime    |
|          | start_station_name         | str         |
|          | start_station_id           | int         |
|          | end_date                   | datetime    |
|          | end_station_name           | str         |
|          | end_station_id             | int         |
|          | bike_id                    | int         |
|          | subscription_type          | str         |
|          | zip_code                   | int         |
| **Weather** | Date                      | date        |
|          | max_temperature_f          | float       |
|          | mean_temperature_f         | float       |
|          | min_temperature_f          | float       |
|          | max_dew_point_f            | float       |
|          | mean_dew_point_f           | float       |
|          | min_dew_point_f            | float       |
|          | max_humidity               | float       |
|          | mean_humidity              | float       |
|          | min_humidity               | float       |
|          | max_sea_level_pressure_inches |    float         |
|          | mean_sea_level_pressure_inches |    float         |
|          | min_sea_level_pressure_inches |     float        |
|          | max_visibility_miles       |      float       |
|          | mean_visibility_miles      |      float       |
|          | min_visibility_miles       |      float       |
|          | max_wind_Speed_mph         |      float       |
|          | mean_wind_speed_mph        |     float        |
|          | max_gust_speed_mph         |     float        |
|          | precipitation_inches       |     float        |
|          | cloud_cover                |      float       |
|          | events                     |    str         |
|          | wind_dir_degrees           |      float       |
|          | zip_code                   | int         |


## Plan d’Analyse

Nous aborderons plusieurs questions clés à travers notre analyse, telles que :

- Question1
- Questions2
- Questions3
- etc


