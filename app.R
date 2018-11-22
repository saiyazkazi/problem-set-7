library(tidyverse)
library(shiny)
library(readr)
library(rsconnect)

y <- read_rds("shinydata")

# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Forecasts vs. Results"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("Upshot"))
      
      
      
    ),
    
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      
      # Output: HTML table with requested number of observations ----
      plotOutput("Forecast")
      
    )
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  datasetInput <- reactive({
    switch(input$dataset,
           "Upshot" = y)
  })
  
  
  output$Forecast <- renderPlot({
    dataset <- datasetInput()
    dataset %>% 
      ggplot(aes(x = forecast, y = result)) + geom_jitter() +facet_wrap(~state)
  })
}


# Create Shiny app ----
shinyApp(ui, server)
deployApp()
