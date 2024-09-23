# Launch in external browser (handy for testing, not required)
options(shiny.launch.browser = .rs.invokeShinyWindowExternal)

library(shiny)
library(shinycroneditor)

ui <- fluidPage(
  titlePanel("Cron Expression Input Widget"),
  mainPanel(
    shinycroneditor::cronOutput("cronschedule1", 
                                label = "Choose your first schedule", 
                                language = "en-US"),
    
    shiny::div(
      "Your first chosen schedule is: ",
      verbatimTextOutput("cronExpression1")
    ),
    
    shinycroneditor::cronOutput("cronschedule2", 
                                label = "Choose your second schedule", 
                                language = "en-US"),
    
    shiny::div(
      "Your chosen second schedule is: ",
      verbatimTextOutput("cronExpression2")
    )
  )
)

server <- function(input, output, session) {

  output$cronschedule1 <- shinycroneditor::renderCron({
    shinycroneditor::cron("0 6 * * *")
  })
  
  output$cronExpression1 <- renderPrint({
    input$cronschedule1
  })
  
  output$cronschedule2 <- shinycroneditor::renderCron({
    shinycroneditor::cron("30 1,3,7 * * *")
  })
  
  output$cronExpression2 <- renderPrint({
    input$cronschedule2
  })
  
}

shinyApp(ui, server)