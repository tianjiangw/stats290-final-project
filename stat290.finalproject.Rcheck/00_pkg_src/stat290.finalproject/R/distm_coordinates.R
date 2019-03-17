#' List all PWS nearby given coordinates and distance
#'
#' @description given coordinates and distance in Bay area, select all PWS with weather data in history
#' @export
#'
#' @param nearby_pws_coordinates funcation name
#' @param lon  parameter
#' @param lat parameter
#' @param distance parameter
#' @param data parameter
#' @param check_date parameter
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr filter select inner_join
#' @importFrom geosphere distm distHaversine
#'
#' @examples
#' \dontrun{
#' l1=-122.27999878
#' l2=37.52000046
#' dis=4000
#' d="2018-05-05"
#' pws_id_selected=nearby_pws_coordinates(lon=l1,lat=l2,distance = dis,data=pws,check_date = d)
#' }
#'
#' @keywords nearby_pws_coordinates
#'
##distm(c(lon1, lat1), c(lon2, lat2), fun = distHaversine)
## @@function nearby_pws_coordinates
## @@input lon,lat and distance
## @@return nearby psw id list

nearby_pws_coordinates <- function(lon=-122.2,lat=37.5,distance=2000,data=pws,check_date="2018-05-05") {
  ##distm calculates distance between coordinates
  ## example: distm=apply(pws[,c("lon","lat")],1,function(y) distm(c(-122.27999878,37.52000046),c(y["lon"],y["lat"]),fun = distHaversine))
  distm=apply(data[,c("lon","lat")],1,function(y) distm(c(lon,lat),c(y["lon"],y["lat"]),fun = distHaversine))
  data %>%
    filter(distm<=distance) %>%
    select(id,lon,lat) %>%
    unique()   %>%
    inner_join(weather_pws,by=c("id"="pws_id")) %>%
    select(id,lon,lat,temp,humidity,wind_dir,wind_dir_degrees,wind_speed,date) %>%
    filter(date==check_date)->
    pws_id_selected
  return(pws_id_selected)

}

