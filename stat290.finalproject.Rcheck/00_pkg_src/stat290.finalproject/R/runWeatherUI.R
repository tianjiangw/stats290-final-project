#'run shiny WeatherUI
#' @export
#' @importFrom shiny fluidPage tabsetPanel tabPanel h3 sidebarLayout sidebarPanel helpText selectInput textInput numericInput actionButton mainPanel plotOutput tableOutput reactive renderTable renderPlot observeEvent shinyApp runApp
#' @importFrom gridExtra grid.arrange
#' @importFrom ggplot2 ggplot geom_bar aes guides geom_text labs geom_point geom_contour ggtitle geom_line scale_x_discrete scale_y_continuous scale_fill_manual coord_flip theme element_blank ylim
#' @importFrom utils head packageVersion read.csv write.csv
#' @importFrom graphics plot
#' @importFrom akima interp
#' @importFrom ggmap ggmap get_map get_stamenmap
#'
#' @examples
#' \dontrun{
#' library(ggmap)
#' library(gridExtra)
#' stat290.finalproject::runWeatherUI()
#' }
#'
#'
runWeatherUI <- function() {
  appDir <- system.file("shiny-examples", "myapp", package = "stat290.finalproject")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `stat290.finalproject`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}

