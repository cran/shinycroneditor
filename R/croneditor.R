#' Cron editor, creates a 'htmlwidgets' object, for use in a 'shiny' dashboard
#'
#' @param schedule Any valid cron schedule, for example "0 6 * * *"
#' @param width How wide should the editor be? Defaults to NULL, meaning 100%
#' @param height How high should the editor be? Defaults to NULL, meaning 32px
#' @param elementId Optionally specifiy the ID of the element
#' @returns Returns a 'htmlwidgets' object that can be used in a 'shiny' app
#' @importFrom htmlwidgets createWidget
#' @examples
#' # A simple cron editor in a Shiny app
#' if (interactive()) {
#' library(shiny)
#' library(shinycroneditor)
#' 
#' ui <- fluidPage(
#' titlePanel("Cron Expression Input Widget"),
#' mainPanel(
#'   shinycroneditor::cronOutput("cronschedule1", 
#'                               label = "Choose your first schedule", 
#'                               language = "en-US"),
#'    
#'    shiny::div(
#'      "Your first chosen schedule is: ",
#'      verbatimTextOutput("cronExpression1")
#'    ),
#'    
#'    shinycroneditor::cronOutput("cronschedule2", 
#'                                label = "Choose your second schedule", 
#'                                language = "en-US"),
#'    
#'    shiny::div(
#'      "Your chosen second schedule is: ",
#'      verbatimTextOutput("cronExpression2")
#'    )
#'  )
#')
#'
#' server <- function(input, output, session) {
#'  
#'  output$cronschedule1 <- shinycroneditor::renderCron({
#'    shinycroneditor::cron("0 6 * * *")
#'  })
#'  
#'  output$cronExpression1 <- renderPrint({
#'    input$cronschedule1
#'  })
#'  
#'  output$cronschedule2 <- shinycroneditor::renderCron({
#'    shinycroneditor::cron("30 1,3,7 * * *")
#'  })
#'  
#'  output$cronExpression2 <- renderPrint({
#'    input$cronschedule2
#'  })
#'  
#'}
#'
#' shinyApp(ui, server)
#' }
#' 
#' @export
cron <- function(schedule, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    schedule = schedule
  )
  
  htmlwidgets::createWidget(
    name = 'cron',
    x,
    width = width,
    height = height,
    package = 'shinycroneditor',
    elementId = elementId
  )
}

#' Shiny bindings for cron editor
#'
#' Output and render functions for using cron editor within 'shiny'
#' applications and interactive 'rmarkdown' documents.
#'
#' @param outputId output variable to read from
#' @param label The label to show, just like in a regular Shiny input element. 
#'   Set to NULL if you don't want a label.
#' @param language The language the cron editor's UI will be in. Choose one of
#'   en-US, nl-NL, es-ES, zh-CN. Note that if you have multiple cron editors
#'   on one page, the last editor's language will be the one for all editors.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a test
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name croneditor-shiny
#' @returns An 'htmlwidgets' object for use in a shiny app, containing a 
#'   placeholder for where the cron input element is rendered.
#' @importFrom htmltools div
#' @export
cronOutput <- function(outputId, label = NULL, language = "en-US", 
                       width = '100%', height = NULL) {

  if (!(language %in% c("en-US", "nl-NL", "zh-CN", "es-ES")))
    stop("The chosen language is not valid")
  
  htmltools::div(
    class = "form-group shiny-input-container",
    `data-language` = language,
    
    if (!is.null(label)) shiny::tags$label(label),
    
    htmlwidgets::shinyWidgetOutput(
      outputId, 
      'cron', 
      width,
      height, 
      package = 'shinycroneditor'
    )
  )
  
}

#' Render the cron input element in a 'shiny' dashboard
#' @returns A 'htmlwidgets' object for use in a 'shiny' app as an input element
#' @rdname croneditor-shiny
#' @export
renderCron <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, cronOutput, env, quoted = TRUE)
}
