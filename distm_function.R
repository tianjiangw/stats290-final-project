library(geosphere)
##distm(c(lon1, lat1), c(lon2, lat2), fun = distHaversine)

## @@function nearby_pws_coordinates
## @@input lon,lat and distance
## @@return nearby psw id list
nearby_pws_coordinates <- function(lon=-122.2,lat=37.5,distance=2000,data=pws) {
  ##distm calculates distance between coordinates
  ## example: distm=apply(pws[,c("lon","lat")],1,function(y) distm(c(-122.27999878,37.52000046),c(y["lon"],y["lat"]),fun = distHaversine))
  distm=apply(data[,c("lon","lat")],1,function(y) distm(c(lon,lat),c(y["lon"],y["lat"]),fun = distHaversine))
  data %>% 
    filter(distm<=distance) %>% 
    select(id) %>% 
    unique()   ->pws_id_selected
    return(pws_id_selected)
}

pws_id_selected=nearby_pws_coordinates(lon=-122.27999878,lat=37.52000046,distance = 2000,data=pws)


## @@function nearby_pws_city
## @@input city name
## @@return nearby psw id list
nearby_pws_city <- function(city_name="Belmont",data=pws) {
  data %>%
    filter(location_city==city_name) %>%
    select(id,lon,lat) %>%
    unique() ->
    pws_id_selected
  return(pws_id_selected)
}

pws_id_selected=nearby_pws_city(city_name = "Belmont",data=pws)

pws %>% filter()
