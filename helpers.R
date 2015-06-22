library(shiny)
library(forecast)
library(ggmap)

## part that will run once for the app
## read station lat and lon for plotting
stationLocation <- read.csv("data/station_location.csv", header = TRUE, sep=",", stringsAsFactors=FALSE, na.strings=c('NA', " ", ""))
rownames(stationLocation) <- 1:nrow(stationLocation)
stations <- stationLocation$station_name
map <- get_map(location = 'united states', zoom = 4, color = 'color')

weatherAnomaly <- read.csv('data/anomalyZooObject.csv', header = TRUE, sep = ",", stringsAsFactors=FALSE, na.strings=c('NA', " ", ""))