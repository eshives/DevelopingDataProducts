library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Air Quality Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("numtemp","What is the temperature?",50,100,value=75),
      numericInput("numwind","What is the wind speed?",0,25,value=10),
      checkboxInput("showtempmodel","Show/Hide Model with Temperature",value=TRUE),
      checkboxInput("showwindmodel","Show/Hide Model with Wind",value=TRUE),
      checkboxInput("showbothmodel","Make Ozone Prediction based on Both Temperature and Wind",value=TRUE)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Documentation",
                 h3("How to use this Shiny APP"),
                 h4("This app uses airquality data from New York in 1973 to predict ozone."),
                 h4("Input a temperature and wind speed in the panel to the left. You can either type in numbers or use the arrows to change the number."),
                 h4("Using the checkboxes in the panel on the left, select which types of models and predictions you would like to be displayed."),
                 h4("Finally, click on the tabs above to see the plots and predictions you selected.")),
        tabPanel("Temperature Only",
                 plotOutput("plot1"),
                 h4("Predicted Ozone Value with Given Temperature"),
                 textOutput("pred1")),
        tabPanel("Wind Speed Only",
                 plotOutput("plot2"),
                 h4("Predicted Ozone Value with Given Wind Speed"),
                 textOutput("pred2")),
        tabPanel("Temperature and Wind Speed",
                 plotOutput("plot3"),
                 h4("Predicted Ozone Value with Given Temperature and Wind Speed"),
                 textOutput("pred3"))
      )
    )
  )
))
