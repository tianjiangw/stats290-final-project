#' history weather
#'
#' @description given city and date range, create table of historical weather for local PWS.
#' @export
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr filter select inner_join
#'
#' @examples
#' history_weather_tbl=history_weather(city_name = "Alameda",start_date="2018-06-01",end_date="2018-12-31")
#' @keywords history_weather
#'

## @@function history_weather
## @@input date_range
## @@return history_weather
history_weather <- function(city_name="Belmont",start_date="2018-05-05",end_date="2018-06-05") {
  pws %>%
    filter(location_city==city_name) %>%
    select(location_city,id,lon,lat) %>%
    unique() %>%
    inner_join(weather_pws,by=c("id"="pws_id")) %>%
    select(location_city,id,lon,lat,temp,temp_min,temp_max,humidity,humidity_min,humidity_max,wind_dir,wind_dir_degrees,wind_speed,wind_speed_max,wind_gust_speed,wind_gust_speed_max,date) %>%
    filter(date>=start_date & date<=end_date) %>%
    mutate(year=as.numeric(format(date,'%Y')),month=as.numeric(format(date,'%m')),day=as.numeric(format(date,'%d')))->
    pws_id_selected
  return(pws_id_selected)
}
