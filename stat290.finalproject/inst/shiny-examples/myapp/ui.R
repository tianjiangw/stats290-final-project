#' Shiny UI Interface
#'
#' @description create user interface for historical weather query
#' @export
#'
#' @importFrom shiny fluidPage tabsetPanel tabPanel h3 sidebarLayout sidebarPanel helpText selectInput textInput numericInput actionButton mainPanel plotOutput tableOutput reactive renderTable renderPlot observeEvent shinyApp runApp
#' @importFrom gridExtra grid.arrange
#' @importFrom ggplot2 ggplot geom_bar aes guides geom_text labs geom_point geom_contour ggtitle geom_line scale_x_discrete scale_y_continuous scale_fill_manual coord_flip theme element_blank ylim
#' @importFrom utils head packageVersion read.csv write.csv
#' @importFrom graphics plot
#' @importFrom akima interp
#' @importFrom ggmap ggmap get_map get_stamenmap
#' @examples
#'
#'\dontrun{
#' library(ggmap)
#' library(gridExtra)
#' stat290.finalproject::runWeatherUI()
#' }
#'}
#'
#' @keywords Shiny Interface
#'
#'
#location_city<-readRDS("location_city.rda")
#weather_pws<-readRDS("weather_pws.rda")
#pws<-readRDS("pws.rda")
#source("get_map.R")
#source("distm_city.R")
#source("wind_rose_plot.R")

#city_lst=list(unique(location_city$city))
ui <- fluidPage(
  tabsetPanel(
    tabPanel(h3("Bay Area Weather by City"),
             sidebarLayout(
               sidebarPanel = sidebarPanel(
                 helpText("input city and date" ),
                 selectInput("city", "city_name:", c('Alameda','Atherton','Belmont','Brisbane','Burlingame',
                                                     'Daly City','Half Moon Bay','Hayward','Menlo Park','Millbrae',
                                                     'Milpitas','Oakland','Pacifica','Palo Alto','Portola Valley',
                                                     'Redwood City','San Bruno','San Carlos','San Francisco',
                                                     'San Jose','San Mateo','Santa Clara','South San Francisco')),
                 textInput("Date","check_date(2018 only,yyyy-mm-dd)",value = "2018-04-01"),
                 numericInput(inputId = "nrows", label = "head_rows", value = 3),
                 actionButton(inputId = "save", label = "Save"),
                 actionButton(inputId = "reload", label = "reload"),
                 actionButton(inputId = "run", label = "run")
               ),
               mainPanel = mainPanel(
                 plotOutput(outputId = "plot"),
                 tableOutput(outputId = "table")
               )
             )
    ),

    tabPanel(h3("Bay Area Weather by Selected Location"), fluid = TRUE,
             sidebarLayout(
               sidebarPanel = sidebarPanel(
                 helpText("input location, range(meter) and date(yyyy-mm-dd)" ),
                 numericInput(inputId = "lon", label = "Longitude", value=-122.27999878),
                 numericInput(inputId = "lat", label = "Latitude", value=37.52000046),
                 numericInput(inputId = "distance", label = "Distance(by meter)", value=4000),
                 textInput("Date2","check_date(2018 only,yyyy-mm-dd)",value = "2018-04-01"),
                 numericInput(inputId = "nrows2", label = "head_rows", value = 3),
                 actionButton(inputId = "save2", label = "Save"),
                 actionButton(inputId = "run2", label = "run")
               ),
               mainPanel = mainPanel(
                 plotOutput(outputId = "plot2"),
                 tableOutput(outputId = "table2")
               )
             )
    ),
    tabPanel(h3("Historical Weather"), fluid = TRUE,
             sidebarLayout(
               sidebarPanel = sidebarPanel(
                 helpText("Input city and date range(yyyy-mm-dd)" ),
                 selectInput("city3", "city_name:", c('Alameda','Atherton','Belmont','Brisbane','Burlingame',
                                                      'Daly City','Half Moon Bay','Hayward','Menlo Park','Millbrae',
                                                      'Milpitas','Oakland','Pacifica','Palo Alto','Portola Valley',
                                                      'Redwood City','San Bruno','San Carlos','San Francisco',
                                                      'San Jose','San Mateo','Santa Clara','South San Francisco')),
                 textInput("start_date3","start_date(2018 only,yyyy-mm-dd)",value = "2018-01-01"),
                 textInput("end_date3","end_date(2018 only,yyyy-mm-dd)",value = "2018-12-31"),
                 numericInput(inputId = "nrows3", label = "head_rows", value = 3),
                 actionButton(inputId = "save3", label = "Save"),
                 actionButton(inputId = "run3", label = "run")
               ),
               mainPanel = mainPanel(
                 plotOutput(outputId = "plot3"),
                 tableOutput(outputId = "table3")
               )
             )
    )
  )
)
