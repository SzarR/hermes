
library(shiny)
library(shinyalert)
library(tidyverse)
library(DT)
library(shinydashboard)

# Define UI for application that draws a histogram
# UI specification --------------------------------------------------------
ui <- dashboardPage(
  skin = "red",
  dashboardHeader(title = "Hermes Nutrition"),
  dashboardSidebar(width = 200,
                   sidebarMenu(
                     menuItem(
                       "Get Nutrition",
                       tabName = "Get Nutrition",
                       icon = icon("dashboard")
                     )
                   )),
  dashboardBody(column(
    width = 8,
    box(
      id = "get_nutrition",
      title = h3("Choose Cut"),
      width = 6,
      collapsible = TRUE,
      solidHeader = TRUE,
      

      br(),
      br(),
      "My flight logbook was saved as a CSV file. The button below
            will establish a secure connection with this CSV file and import
            each row of the flight log as a table into this application. Each
            of the columns of the logbook is sortable, just click on the header
            name to sort the logbook on a particular column.",
      br(),
      br(),
      actionButton(
        inputId = "get_logbook",
        label = "Establish Datalink",
        width = 220)
    )
  ),
  column(
    width = 12,
    box(
      title = h3("Logbook Entries"),
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      DT::dataTableOutput("table_logbook")
    )
  ))
)

# Define server logic required to draw a histogram
# shinyServer(function(input, output) {
# 
# # Reactive Values Configuration -------------------------------------------
# 
#   #Year_Select <- reactive({input$YearSelect})
#   
# # Read CSV Upon Action Button ---------------------------------------------
#   logbook <- eventReactive(input$get_logbook, {
#     fetch_logbook(static = TRUE)
#   })
# 
# # Display table
#   output$table_logbook <-
#     DT::renderDataTable({
#       logbook()
#     })
#   
# # Render viz_year plot
#   output$viz_year <- renderPlot({
#     viz_flights_by_year()
#     })
#   
# # Another attempt
#   attempt2_eventReactive <- eventReactive(input$YearSelect,
#                                           {
#                                             logbook %>% 
#                                               filter(lubridate::year(logbook$Date) == input$YearSelect) %>%
#                                               mutate(month = month.abb[lubridate::month(Date)]) %>%
#                                               mutate(month = factor(month, levels = month.abb)) %>%
#                                               group_by(month, .drop = FALSE) %>% 
#                                               summarise(Total = sum(Total, na.rm = TRUE))
#                                           })
# 
# })

server <- function(input, output) {
  
  # Read CSV Upon Action Button ---------------------------------------------
  logbook <- eventReactive(input$get_logbook, {
    fetch_logbook(static = TRUE)
  })
  
  # Display table
  output$table_logbook <-
    DT::renderDataTable({
      logbook()
    })
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  # Collapse Logbook box after clicking button
  observeEvent(input$get_logbook,{js$collapse("datalink_panel")})
}

# Run the application 
shinyApp(ui = ui, server = server)
