# Edit cron schedules in a nice way, in R Shiny
[![R build status](https://github.com/DatalabFabriek/shinycroneditor/workflows/R-CMD-check/badge.svg)](https://github.com/DatalabFabriek/shinycroneditor/actions)

An R 'shiny' package that creates a htmlwidget for inputting a cron schedule in a 
nice way. It implements 
[JossyDevers/cron-expression-input](https://github.com/JossyDevers/cron-expression-input/),
but then for use as a Shiny input element.

![Screenshot of the Shiny example app with shinycroneditor](dev/img/screenshot-example-app.png)

## Installing
We've submitted this as a package to CRAN, but that process takes some time. 
For now, install via devtools::install_github():

```r
devtools::install_github("DatalabFabriek/shinycroneditor")
```

## How to use in Shiny
In your UI, add:
```r
shinycroneditor::cronOutput(
  "cronschedule1", 
  label = "Choose your first schedule", 
  language = "en-US")
```

Then, in your server, render the actual editor:
```r
output$cronschedule1 <- shinycroneditor::renderCron({
  shinycroneditor::cron("0 6 * * *")
})
```

Now you can simply use the cron schedule anywhere as a regular input variable:
```r
shiny::observe({
  message(input$cronschedule1)
})
```

Have a look at [inst/examples/shiny-app.R](https://github.com/DatalabFabriek/shinycroneditor/blob/main/inst/examples/shiny-app.R) for a
working example.

## License
See [LICENSE.md](https://github.com/DatalabFabriek/shinycroneditor/blob/main/LICENSE.md). Feel free to open a pull request or issue!

## Want to work for us?
Do you like Shiny and do you live in the Netherlands? Get in touch via
[datalab.nl](https://www.datalab.nl). We're always looking for good programmers!