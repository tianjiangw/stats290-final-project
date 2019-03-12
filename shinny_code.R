library(shiny)
library(gridExtra)

#location_city<-readRDS("location_city.rda")
#weather_pws<-readRDS("weather_pws.rda")
#pws<-readRDS("pws.rda")
source("get_map.R")
source("distm_function.R")
source("wind_rose_plot.R")

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
server <- function(input, output, session) {
  #tab1
  
  data<- reactive(x= nearby_pws_city(city_name=input$city,check_date=input$Date))
  df <- reactive(head(data2(), n = input$nrows))
  
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
    write.csv(df(), file = "data.csv")
  })
}

shinyApp(ui = ui, server = server)

