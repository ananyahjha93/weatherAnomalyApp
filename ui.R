library(shiny)
library(forecast)
library(ggmap)

shinyUI(fluidPage(
  titlePanel("Weather Anomaly Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      includeHTML("www/js/myselect2.js"),
      selectInput("station", label = "Stations", choices = stations, selectize = TRUE),
      dateInput("date", label = "Date", value = NULL, min = "2014-01-01", max = "2016-12-31", format = "yyyy-mm-dd", startview = "month", weekstart = 0, language = "en"),
      submitButton(text = "Submit", icon = NULL),
      h3('Documentation'),
      p('1. This app forecasts the temperature deviation from the mean on a particular day and location.'),
      p('2. Give the app a few seconds to load initially or calculate forecasts.'),
      p('3. Please scroll down if the map is not visible.'),
      p('4. Temperature deviation from the mean is deviation of a day\'s temperature from the historical average.'),
      p('5. The dataset used is US Weather Anomalies (1964-2013) and is publicly available on enigma.io. Data from 2010 onwards has been selected so that the model predicts from a relevant subset.'),
      p('6. Select a station (you can type and search) and a date to obtain a forecast, a graph showing the trend of temperature deviation from mean and a map showing the location of the weather station.'),
      p('7. The shaded regions around the forecast in the graph represent the 95% and the 80% confidence intervals.')
    ),
    mainPanel(
      h4('Station Selected'),
      verbatimTextOutput("input_station"),
      h4('Date Selected'),
      verbatimTextOutput("input_date"),
      h4('Forecasted Mean Deviation in Temperature (Celsius)'),
      verbatimTextOutput("forecast_value"),
      h4('Graph showing forecast for temperature deviation from the mean value'),
      imageOutput('plot'),
      h4('Map showing the location of the selected weather station'),
      imageOutput('map')
    )
  )
))