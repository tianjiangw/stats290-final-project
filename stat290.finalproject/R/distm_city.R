#' List all PWS nearby the city selected
#'
#' @description given a city name in Bay area, select all PWS with weather data in history
#' @export
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr filter select inner_join
#'
#' @examples
#' pws_id_selected <- nearby_pws_city(city_name = "Alameda",check_date="2018-05-05")
#' @keywords nearby_pws_city
#'
## @@function nearby_pws_city
## @@input city name
## @@return nearby psw id list
nearby_pws_city <- function(city_name="Belmont", check_date="2018-05-05") {
  pws %>%
    filter(location_city==city_name) %>%
    select(location_city,id,lon,lat) %>%
    unique() %>%
    inner_join(weather_pws,by=c("id"="pws_id")) %>%
    select(location_city,id,lon,lat,temp,humidity,wind_dir,wind_dir_degrees,wind_speed,date) %>%
    filter(date==check_date)->
    pws_id_selected
  return(pws_id_selected)
}

