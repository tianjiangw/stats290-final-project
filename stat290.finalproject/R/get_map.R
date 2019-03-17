#' Create a ggplot map using google map
#'
#' @description 1) Generate a map based on the selected list of personal weather stations(pws)
#'              2) plot contour lines based on tempatures in the neighborhood
#' @export
#'
#' @param weather_map function name
#' @param df parameter
#'
#' @importFrom akima interp
#' @importFrom ggplot2 aes guides geom_text labs geom_point geom_contour
#' @importFrom ggmap ggmap get_map get_stamenmap
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' library(ggmap)
#' library(akima)
#' pws_id_selected <- nearby_pws_city(city_name = "Alameda",check_date="2018-05-05")
#' weather_map(df=pws_id_selected)
#' }
#' @keywords weather_map
#'
#'
#'
#'
# loading the required packages
#library(ggplot2)
#library(ggmap)
#library(akima)
#loading data
#location_city<-readRDS("location_city.rda")
#weather_pws<-readRDS("weather_pws.rda")
#pws<-readRDS("pws.rda")

#create temperature map
weather_map <- function(df=pws_id_selected) {
  #create contour line
  surface <- with(df, interp(lon, lat, temp, linear = FALSE))
  srfc <- expand.grid(lon = surface$x, lat = surface$y)
  srfc$temp <- as.vector(surface$z)
  tconts <- geom_contour(aes(x = lon, y = lat, z = temp), data = srfc, na.rm = TRUE)
  # getting the map
  wu_map <- get_map(location = c(lon = mean(df$lon), lat = mean(df$lat)), zoom = 14,
                    maptype =  "terrain-background", scale = 2)
  # plotting the map with some points on it
  ggmap(wu_map) +
    geom_point(data = df, aes(x = df$lon, y = df$lat, fill = "blue", alpha = 0.8), size = 3, shape = 21) +
    guides(fill=FALSE, alpha=FALSE, size=FALSE)+  geom_text(data = df, aes(x = df$lon, y = df$lat, label = paste(df$temp,"\u00B0C")), size = 3, vjust = 0, hjust = -0.5) +
    labs(title = paste0("Bay Area Weather - ",unique(df$location_city)," (",unique(df$date),")"), x = "Lon", y = "Lat", color = "Tempature\n", size = 2,fill = "blue") +
    #stat_density2d(data=df,aes(x=df$lon,y=df$lat,z=df$temp))
    tconts ##add contour line

}
