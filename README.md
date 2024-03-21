[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/Fj4cXJY4)

# Analyse des Données du Service de Vélos en Libre-Service de la Baie de San Francisco
![San Francisco Bike](https://que-faire.voyage/wp-content/uploads/sites/13/2022/05/cyclistes-velo-san-francisco.jpg "San Francisco Bike")

## Introduction

Ce projet vise à explorer et analyser les données du service de vélos en libre-service de la Baie de San Francisco, avec l'objectif de comprendre les facteurs influençant l'utilisation des vélos et d'identifier les tendances d'utilisation. Les données, provenant de Kaggle, incluent des informations détaillées sur les stations de vélo, la météo, le statut de la station à un moment donné, et les trajets effectués.

## Données

### Source

Les données proviennent de [Kaggle](https://www.kaggle.com/datasets/benhamner/sf-bay-area-bike-share?select=trip.csv), et sont constituées de quatre fichiers CSV distincts : `Station`, `Weather`, `Status`, et `Trip`. 

### Description
Nous avons choisi ces datasets pour les informations diversifiées qu’ils proposent, décrites ci-dessous

- **Station** : Ce dataset contient des données qui représentent une station où les utilisateurs peuvent récupérer ou restituer des vélos.
          - *Contenu* : 70 éléments avec 7 caractéristiques.
- **Weather** : Celuic-i donne des informations sur le nombre de vélos et de quais disponibles pour une station et une minute données.
          - *Contenu* : 72M éléments avec 24 caractéristiques.
- **Status** : Ici sont donné des informations sur les déplacements individuels à vélo.
          - *Contenu* : 670 000 éléments avec 4 caractéristiques.
- **Trip** : Ce dernier dataset nous donne des informations sur la météo un jour spécifique pour certains codes postaux
          - *Contenu* : 3665 éléments avec 11 caractéristiques
### Format

Chaque ensemble de données est formaté en CSV, facilitant l'importation et l'analyse dans divers outils d'analyse de données.

### Catégories et Sous-groupes

Les données sont divisées en quatre catégories principales correspondant aux aspects clés du service de vélos en libre-service, permettant une analyse multidimensionnelle de l'utilisation des vélos en fonction de la météo, de la disponibilité des vélos, et des préférences de trajet des utilisateurs.

### Caractéristiques des Données par Fichier

| Fichier  | Caractéristique                | Type        |Description|
|----------|--------------------------------|-------------|------------------------|
| **Station** | id                         | int         |Identifiant unique de la station|
|          | name                       | str         |Nom de la station de vélo|
|          | latitude                   | float       |Coordonnée géographique en latitude de la station|
|          | longitude                  | float       |Coordonnée géographique en longitude de la station|
|          | dock_count                 | int         |Nombre de places de vélos disponibles dans la station|
|          | city                       | str         |Nom de la ville dans laquelle la station est instalée|
|          | installation_date          | date        |Date d'installation de la station|
| **Status**  | station_id                  | int         |Identifiant unique de la station|
|          | bikes_available            | int         |Nombre de vélos disponibles dans la station|
|          | docks_available            | int         |Nombre de places vides disponibles dans la station|
|          | time                       | datetime    |Heure actuelle|
| **Trip**    | id                         | int         |Identifiant unique du trajet|
|          | duration                   | int         |Durée du trajet|
|          | start_date                 | datetime    |Date et heure de début du trajet|
|          | start_station_name         | str         |Nom de la station de départ|
|          | start_station_id           | int         |Identifiant unique de la station de départ|
|          | end_date                   | datetime    |Date et heure de fin de trajet|
|          | end_station_name           | str         |Nom de la station de fin |
|          | end_station_id             | int         |Identifiant unique de la station d'arrivée|
|          | bike_id                    | int         |Identifiant unique du vélo|
|          | subscription_type          | str         |Type d'abonnement de l'utilisateur|
|          | zip_code                   | int         |Code postal|
| **Weather** | Date                      | date        |Date|
|          | max_temperature_f          | float       |Température maximale en degrés Fahrenheit|
|          | mean_temperature_f         | float       |Température moyenne en degrés Fahrenheit|
|          | min_temperature_f          | float       |Température minimale en degrés Fahrenheit|
|          | max_dew_point_f            | float       |Point de rosée maximal en degrés Fahrenheit|
|          | mean_dew_point_f           | float       |Point de rosée moyen en degrés Fahrenheit|
|          | min_dew_point_f            | float       |Point de rosée minimal en degrés Fahrenheit|
|          | max_humidity               | float       |Humidité maximale en %|
|          | mean_humidity              | float       |Humidité moyenne en %|
|          | min_humidity               | float       |Humidité minimale %|
|          | max_sea_level_pressure_inches |    float         |Pression atmosphérique maximale au niveau de la mer en pouces de mercure|
|          | mean_sea_level_pressure_inches |    float         |Pression atmosphérique moyenne au niveau de la mer en pouces de mercure|
|          | min_sea_level_pressure_inches |     float        |Pression atmosphérique minimale au niveau de la mer en pouces de mercure|
|          | max_visibility_miles       |      float       |Visibilité maximale en miles|
|          | mean_visibility_miles      |      float       |Visibilité moyenne en miles|
|          | min_visibility_miles       |      float       |Visibilité minimale en miles|
|          | max_wind_Speed_mph         |      float       |Vitesse maximale du vent  en miles par heure|
|          | mean_wind_speed_mph        |     float        |Vitesse moyenne du vent  en miles par heure|
|          | max_gust_speed_mph         |     float        |Vitesse maximale des rafales  en miles par heure|
|          | precipitation_inches       |     float        |Volume des précipitations en pouces|
|          | cloud_cover                |      float       |Couverture nuageuse en oktas|
|          | events                     |    str         |Commentaires sur la météo du jour (Brouillard, pluie...)|
|          | wind_dir_degrees           |      float       |Direction du vent en degrés|
|          | zip_code                   | int         |Code postal |


## Plan d’Analyse

Nous aborderons plusieurs questions clés à travers notre analyse, telles que :

- Question1
- Questions2
- Questions3
- etc


