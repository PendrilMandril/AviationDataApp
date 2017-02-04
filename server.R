library(ggplot2)
library(dplyr)
library(magrittr)
library(lubridate)
library(readr)

flights <- read_csv("AviationDataEnd2016UP.csv")
flights$Year <- year(flights$Event.Date) %>% as.integer()
flights <- select(flights, Total.Fatal.Injuries, Year, Purpose.of.Flight,
                  Aircraft.Damage, Report.Status, Country, Aircraft.Category, Amateur.Built) 

flights$Amateur.Built  %<>%  as.factor()
function(input, output) {
  
  # Filter the flights, returning a data frame
  getFlights <- reactive({
    f <- flights %>% filter(
      Total.Fatal.Injuries > input$fatalInjuries, 
      Year > input$year[1],
      Year < input$year[2]
    )
    
    if (input$purposeFlight != "All") {
      f <- f %>% filter(Purpose.of.Flight == input$purposeFlight)
    }
    if (input$aircraftDamage != "All" & input$aircraftDamage != "") {
      f <- f %>% filter(Aircraft.Damage == input$aircraftDamage)
    }
    if (input$reportStatus != "All" & input$reportStatus != "") {
      f <- f %>% filter(Report.Status == input$reportStatus)
    }
    if (input$country!= "All" & input$country != "") {
      f <- f %>% filter(Country == input$country)
    }
    if (input$aircraftCategory != "All" & input$aircraftCategory != "") {
      f <- f %>% filter(Aircraft.Category == input$aircraftCategory)
    }
    
    return(f)
  })
  
  output$plot1 <- renderPlot({
    myFlights <- getFlights()
    ggplot(myFlights, aes(x = Year)) + geom_bar(aes(fill = Amateur.Built), position = "stack")
  })
  output$n_flights <- renderText({
    myFlights <- getFlights()
    nrow(myFlights) 
  })
}