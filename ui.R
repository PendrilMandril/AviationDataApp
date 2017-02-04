library(ggvis)

fluidPage(
  titlePanel("Aviation data explorer"),
  fluidRow(
    column(3,
           wellPanel(
             h4("Select options"),
             h5("This apps allows us to analyze easily the aviation data set. Select the parameters
                to filter the data."),
             sliderInput("year", "Year of the accident", 1982, 2017, value = c(1982, 2017)),
             sliderInput("fatalInjuries", "At least X deaths",
                         0, 350, 0, step = 1),
             textInput("country", "Country name"),
             selectInput("aircraftDamage", "Damage of the aircraft",
                         c("All", "Destroyed", "Substantial", "Minor")),
             selectInput("aircraftCategory", "Category of the aircraft",
                         c("All", "Airplane", "Balloon", "Blimp", "Glider", "Gyrocraft",
                           "Gyroplane", "Helicopter", "Powered-Lift", "Powered Parachute",
                           "Rocket", "Ultralight", "Unknown", "Weight-Shift")),
             selectInput("reportStatus", "Status of the report",
                         c("All", "Factual", "Foreign", "Preliminary", "Probable Cause")),
             selectInput("purposeFlight", "Purpose of the flight",
                         c("All", "Aerial Application", "Aerial Observation", "Air Drop", "Air Race/Show",
                           "Banner Tow", "Business", "Executive/Corporate", "External Load", "Ferry",
                           "Firefighting", "Flight Test", "Glider Tow", "Instructional",
                           "Other Work Use", "Personal", "Positioning", "Public Aircraft",
                           "Public Aircraft - Federal", "Public Aircraft - Local",
                           "Public Aircraft - State", "Skydiving", "Unknown"))
           )
    ),
    column(9,
           plotOutput("plot1"),
           wellPanel(
             span("Number of flights selected:",
                  textOutput("n_flights")
             )
           )
    )
  )
)
