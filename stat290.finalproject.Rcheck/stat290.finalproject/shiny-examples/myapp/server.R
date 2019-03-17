#' Shiny server
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

server <- function(input, output, session) {
  #tab1

  #data<- reactive(if (!input$reload|input$run|input$save) {x= nearby_pws_city(city_name=input$city,check_date=input$Date)} else x=read.csv("data.csv"))
  data<- reactive(if (!input$reload|input$run) {
    x= nearby_pws_city(city_name=input$city,check_date=input$Date)
  }
  else {
    #session$reload()
    x= read.csv("data.csv")
  })
  #eventReactive(if (input$reload & input$run) {session$reload()})
  df <- reactive(head(data(), n = input$nrows))

  output$plot <- renderPlot(expr = {
    p1=plot(x = weather_map(data()))
    p2=plot(x = weather_windrose(data()))
    grid.arrange(p1,p2, ncol=2,widths = c(2,2))
  })


  output$table <- renderTable(expr = {
    df()
  })

  #tab2
  data2 <- reactive(x= nearby_pws_coordinates(lon=input$lon,lat=input$lat,distance=input$distance,check_date=input$Date2,data=pws))
  df2 <- reactive(head(data2(), n = input$nrows2))

  output$plot2 <- renderPlot(expr = {
    p1=plot(x = weather_map(data2()))
    p2=plot(x = weather_windrose(data2()))
    grid.arrange(p1,p2, ncol=2,widths = c(2,2))
  })

  output$table2 <- renderTable(expr = {
    df2()
  })

  #tab3
  data3 <- reactive(x= history_weather(city_name =input$city3,start_date=input$start_date3,end_date=input$end_date3))
  df3 <- reactive(head(data3(), n = input$nrows3))

  output$plot3 <- renderPlot(expr = {
    p1=plot(x = history_temp_daily(data3()))
    p2=plot(x = history_temp_month(data3()))
    p3=plot(x = history_humidity_daily(data3()))
    p4=plot(x = history_humidity_month(data3()))
    grid.arrange(p1,p2,p3,p4, nrow=2,ncol=2,heights = c(3,3))
  })

  output$table3 <- renderTable(expr = {
    df3()
  })


  ## Add logic so that when the "save" button is pressed, the data
  ## is saved to a CSV file called "data.csv" in the current
  ## directory.
  observeEvent(eventExpr = input$save, handlerExpr = {
    #write.csv(df(), file = "data.csv")
    write.csv(data(), file = "data.csv")
  })
  observeEvent(eventExpr = input$save2, handlerExpr = {
    write.csv(data2(), file = "data2.csv")
  })
  observeEvent(eventExpr = input$save3, handlerExpr = {
    write.csv(data3(), file = "data3.csv")
  })

  #  observeEvent(eventExpr = input$reload, handlerExpr = {
  #    data=read.csv("data.csv")
  #    print("REFRESHING CSV!")
  #    p1=plot(x = weather_map(data()))
  #    p2=plot(x = weather_windrose(data()))
  #  })


}
