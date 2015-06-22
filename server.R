library(shiny)
library(forecast)
library(ggmap)



# Define server logic
shinyServer(function(input, output) {
  output$input_station <- renderPrint({input$station})
  output$input_date <- renderPrint({input$date})
  output$station_lat <- renderPrint({stationLocation[which(stationLocation$station_name == input$station), ]$latitude})
  output$station_lon <- renderPrint({stationLocation[which(stationLocation$station_name == input$station), ]$longitude})
  
  meanForecastValue <- function(weatherStation, date) {
    timeSeries <- ts(weatherAnomaly[, weatherStation], start = c(2010, 1), end = c(2013, 365), frequency = 365)
    fit <- HoltWinters(timeSeries)
    forecastValues <- forecast(fit, as.numeric(date - as.Date("2013-12-31")))
    output$plot <- renderPlot({plot(forecastValues, main = "Forecast for the entered date and station", xlab = "Year" , ylab = "Deviation from Mean (Celsius)")})
    meanForecast <- forecastValues$mean
    meanForecast[length(meanForecast)]
  }
  
  output$forecast_value <- renderPrint({meanForecastValue(gsub(" ", "_", input$station), input$date)})
  
  stationLatitude <- function(weatherStation) {
    lat <- stationLocation[which(stationLocation$station_name == input$station), ]$latitude
    lat  
  }
  
  stationLongitude <- function(weatherStation) {
    lon <- stationLocation[which(stationLocation$station_name == input$station), ]$longitude
    lon
  }
  
  output$map <- renderPlot({
    mapPoints <- ggmap(map) + geom_point(aes_string(x = stationLongitude(input$station), y = stationLatitude(input$station)), data = stationLocation, color = "red", alpha = 1, shape = 17, cex = 5)
    mapPoints
  })
  
})