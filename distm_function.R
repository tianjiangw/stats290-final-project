library(tidyverse)
library(geosphere)
##distm(c(lon1, lat1), c(lon2, lat2), fun = distHaversine)

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

#pws_id_selected=nearby_pws_city(city_name = "Alameda",check_date="2018-05-05")


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

#pws_id_selected=nearby_pws_coordinates(lon=-122.27999878,lat=37.52000046,distance = 4000,data=pws,check_date = "2018-05-05")


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

#history_weather_tbl=history_weather(city_name = "Alameda",start_date="2018-06-01",end_date="2018-12-31")