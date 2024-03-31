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
- **Weather** : Celui-ci donne des informations sur le nombre de vélos et de quais disponibles pour une station et une minute données.
  - *Contenu* : 72M éléments avec 24 caractéristiques.
- **Status** : Ici sont données des informations sur les déplacements individuels à vélo.
  - *Contenu* : 670 000 éléments avec 4 caractéristiques.
- **Trip** : Ce dernier dataset nous donne des informations sur la météo un jour spécifique pour certains codes postaux
  - *Contenu* : 3665 éléments avec 11 caractéristiques
### Format

Chaque ensemble de données est formaté en CSV, ce qui facilite l'importation et l'analyse dans divers outils d'analyse de données.

### Catégories et Sous-groupes

Les données sont divisées en quatre catégories principales correspondant aux aspects clés du service de vélos en libre-service, permettant une analyse multidimensionnelle de l'utilisation des vélos en fonction de la météo, de la disponibilité des vélos, et des préférences de trajet des utilisateurs.

### Caractéristiques des Données par Fichier

| Fichier  | Caractéristique                | Type de données (Quantitatif / Qualitatif)       |Description|
|----------|--------------------------------|-------------|------------------------|
| **Station** | id                         | discrète        |Identifiant unique de la station|
|          | name                       | nominale         |Nom de la station de vélo|
|          | latitude                   | continue       |Coordonnée géographique en latitude de la station|
|          | longitude                  | continue       |Coordonnée géographique en longitude de la station|
|          | dock_count                 | discrète         |Nombre de places de vélos disponibles dans la station|
|          | city                       | nominale         |Nom de la ville dans laquelle la station est instalée|
|          | installation_date          | discrète        |Date d'installation de la station|
| **Status**  | station_id                  | discrète         |Identifiant unique de la station|
|          | bikes_available            | discrète         |Nombre de vélos disponibles dans la station|
|          | docks_available            | discrète         |Nombre de places vides disponibles dans la station|
|          | time                       | discrète    |Heure actuelle|
| **Trip**    | id                         | discrète         |Identifiant unique du trajet|
|          | duration                   | discrète         |Durée du trajet|
|          | start_date                 | discrète    |Date et heure de début du trajet|
|          | start_station_name         | nominale         |Nom de la station de départ|
|          | start_station_id           | discrète         |Identifiant unique de la station de départ|
|          | end_date                   | discrète    |Date et heure de fin de trajet|
|          | end_station_name           | nominale         |Nom de la station de fin |
|          | end_station_id             | discrète         |Identifiant unique de la station d'arrivée|
|          | bike_id                    | discrète         |Identifiant unique du vélo|
|          | subscription_type          | nominal         |Type d'abonnement de l'utilisateur|
|          | zip_code                   | discrète         |Code postal|
| **Weather** | Date                      | discrète        |Date|
|          | max_temperature_f          | continue       |Température maximale en degrés Fahrenheit|
|          | mean_temperature_f         | continue       |Température moyenne en degrés Fahrenheit|
|          | min_temperature_f          | continue       |Température minimale en degrés Fahrenheit|
|          | max_dew_point_f            | continue       |Point de rosée maximal en degrés Fahrenheit|
|          | mean_dew_point_f           | continue       |Point de rosée moyen en degrés Fahrenheit|
|          | min_dew_point_f            | continue       |Point de rosée minimal en degrés Fahrenheit|
|          | max_humidity               | continue       |Humidité maximale en %|
|          | mean_humidity              | continue       |Humidité moyenne en %|
|          | min_humidity               | continue       |Humidité minimale %|
|          | max_sea_level_pressure_inches |    continue         |Pression atmosphérique maximale au niveau de la mer en pouces de mercure|
|          | mean_sea_level_pressure_inches |    continue         |Pression atmosphérique moyenne au niveau de la mer en pouces de mercure|
|          | min_sea_level_pressure_inches |     continue        |Pression atmosphérique minimale au niveau de la mer en pouces de mercure|
|          | max_visibility_miles       |      continue       |Visibilité maximale en miles|
|          | mean_visibility_miles      |      continue       |Visibilité moyenne en miles|
|          | min_visibility_miles       |      continue       |Visibilité minimale en miles|
|          | max_wind_Speed_mph         |      continue       |Vitesse maximale du vent  en miles par heure|
|          | mean_wind_speed_mph        |     continue        |Vitesse moyenne du vent  en miles par heure|
|          | max_gust_speed_mph         |     continue        |Vitesse maximale des rafales  en miles par heure|
|          | precipitation_inches       |     continue        |Volume des précipitations en pouces|
|          | cloud_cover                |      continue       |Couverture nuageuse en oktas|
|          | events                     |    nominale        |Commentaires sur la météo du jour (Brouillard, pluie...)|
|          | wind_dir_degrees           |      continue       |Direction du vent en degrés|
|          | zip_code                   | dicrète         |Code postal |


## Plan d’Analyse

Nous aborderons plusieurs questions clés à travers notre analyse, qui se divisent en deux parties pour répondre à notre problématique :

**Quel sont les facteurs qui ont un impact l’utilisation des vélos ?:**

1. Quelle est la répartition des statuts des utilisateurs en fonction du trajet effectué (Subscriber/Customer) ?
   - Pour les long trajets on peut s’attendre à ce qu’il y ait un pourcentage plus élevé de "subscribers" que de "customers".
   - *_Graphique_* : Bar Chart
   - *_Dataset_* : trip.csv
   - *_Features_* : subscription_type, start_date, end_date 
   
2. Est-ce que les stations sont bien dimensionnées ? (suffisamment de docks)
   - On va chercher à savoir si les capacités d’accueil des stations sont adaptées au flux entrant et sortant d’utilisateurs sur chaque station. On va comparer la capacité d’accueil d’une station par rapport au nombre de vélos qui y sont. Le problème que l’on peut rencontrer est au niveau du nombre d’éléments (environ 82 stations).
   - *_Graphique_* : Multi Set Bar Chart ou Population chart
   - *_Dataset_* : trip.csv, station.csv
   - *_Features_*: dock_count, name, station_name
   
3. Est-ce que le dénivelé a un impact sur les trajets effectués par les utilisateurs ?
   - Nous nous attendons à ce qu’un trajet possédant plus de dénivelé soit moins emprunté par les utilisateurs.
   - *_Graphique_*: Flow Map + Carte topographique à intégrer
   - *_Dataset_*: trip.csv, station.csv
   - *_Features_*: lat, long, name, station_name, start_station_name, end_station_name
   
4. Quelle condition météorologique a le plus d’impact sur l’utilisation des vélos ?
   - Nous souhaitons observer quelle condition météorologique impact le plus l’utilisation des vélos.
Nous mettrons en comparaison les différentes informations météorologiques que nous possédons avec les données d’utilisations des vélos au cours d’une année.
   - *_Graphique_*: Bar chart
   - *_Dataset_*: weather.csv, trip.csv
   - *_Features_*: start_date, date, mean_temperature_f, mean_humidity, mean_wind_speed_mph, precipitation_inches, cloud_cover, wind_dir_degrees

**Quelles sont les tendances d’utilisation des vélos ?**

5. Quel est la durée moyenne des trajets en fonction de la météo ?
   - On va chercher à observer la durée moyenne des trajets en fonction des conditions météorologiques.
   - *_Graphique_*: Bar chart (pour chaque condition météorologique ~6)
   - *_Dataset_*: weather.csv, trip.csv
   - *_Features_*: start_date, end_date, duration, date, mean_temperature_f, mean_humidity, mean_wind_speed_mph, precipitation_inches, cloud_cover, wind_dir_degrees
   
6. Comment la météo influence les trajets, en termes de distance et de destination ?
   - Nous allons chercher quels sont les trajets effectués en fonction des conditions météorologiques.
   - *_Graphique_*: Connexion Map pour chaque condition météorologique  
   - *_Dataset_*: trip.csv, weather.csv, station.csv
   - *_Features_*: start_date, end_date, date, start_station_name, end_station_name, name, lat, long, mean_temperature_f, mean_humidity, mean_wind_speed_mph, precipitation_inches, cloud_cover, wind_dir_degrees
   
7. Quels sont les trajets les plus fréquentés ?
   - Nous voulons observer quels sont les trajets les plus fréquentés, notamment leur type (trajet pour aller vers un lieu de travail, école, université, loisir). Nous n’aurons pas le trajet exact étant donné que le dataset nous donne seulement le point de départ et le point d'arrivée.
   - *_Graphique_*: Arc diagram
   - *_Dataset_*: trip.csv
   - *_Features_*: start_station, end_station
   
8. Quelles sont les stations les plus fréquentées (départs et arrivées) ?
   - Nous cherchons à observer quelles stations ont le nombre d'utilisateurs le plus important.
   - *_Graphique_*: Dot Map
   - *_Dataset_*: trip.csv
   - *_Features_*: start_station, end_station
   
9. Quelles sont les durées des trajets en fonction des heures de la journée, de la saison ? Et comment l’utilisation des vélos varie au cours de la journée ?
   - On cherche à représenter l’utilisation des vélos au cours de la journée, de l’année et voir si, au sein d’une même journée, il y a des plages horaires d’utilisation plus fortes ou faibles.
   - *_Graphique_*: Bar chart (3 graphiques)
   - *_Dataset_*: trip.csv
   - *_Features_*: start_date, end_date, duration
   
10. Quel est le rapport entre départs et arrivées de chaque station ?
    - On observe s’il y a des stations qui ont plus de départs que d’arrivées, et inversement.
    - *_Graphique_*: Dot map
    - *_Dataset_*: trip.csv
    - *_Features_*: start_station_name, end_station_name
   
11. Existe-il une relation entre le nombre de vélos disponible à une station et la météo ?
    - On voudrait voir si un temps moins propice à l’utilisation d’un vélo fait qu’il y a plus de vélos disponibles à une station.
    - *_Graphique_*: Heatmap ou Scatterplot 
    - *_Dataset_*: status.csv, weather.csv
    - *_Features_*: bikes_available, time, date, mean_temperature_f, mean_humidity, mean_wind_speed_mph, precipitation_inches, cloud_cover, wind_dir_degrees






