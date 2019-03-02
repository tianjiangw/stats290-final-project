library(jsonlite)
citylist=c("Alameda","Atherton","Belmont","Brisbane","Burlingame","Daly City","Half_Moon_Bay","Hayward","menlo park","Millbrae","Milpitas","Oakland","Pacifica","Palo_Alto","Portola Valley","Redwood City","San Bruno","San_Carlos","San_Francisco","San_Jose","San_Mateo","Santa Clara","South San Francisco")
json_data={}
location={}
location_city={}
pws={}
airport={}

for (i in 1:length(citylist)) {
  json_data=fromJSON(paste0(citylist[i],".json"))
  location[[i]]=json_data[["location"]]
  location_city[[i]]=location[[i]][-17]
  #location_city[[i]]=json_data$location[-17]
  pws[[i]]=cbind(location_city=location[[i]][["city"]],location[[i]]$nearby_weather_stations$pws$station)
  airport[[i]]=cbind(location_city=location[[i]][["city"]],location[[i]]$nearby_weather_stations$airport$station)
}

location_city=do.call(rbind,location_city)
pws= do.call(rbind,pws)
saveRDS(pws,"pws.rda")

airport= do.call(rbind,airport)
saveRDS(pws,"airport.rda")
pws_id_list=unique(pws$id)
airport_id_list=unique(airport$icao)

#json_data= fromJSON("Belmont.json")
#location <- json_data$location
#pws <- json_data$location$nearby_weather_stations$pws$station
#airport <- json_data$location$nearby_weather_stations$airport$station

weather_pws=list()
for (i in 1:length(pws_id_list)) {
file=paste0("https://api-ak.wunderground.com/api/606f3f6977348613/history_2018010120181231/units:metric/v:2.0/q/pws:",pws_id_list[[i]],".json")
json_data=fromJSON(file)
path1=json_data$history$days$summary$date
path2=json_data$history$days$summary

try(weather_pws[[i]] <- tibble(pws_id=pws_id_list[[i]],epoch=path1$epoch, 
       temp_max=path2$max_temperature, temp_min=path2$min_temperature,temp=path2$temperature, 
       dewpoint_max=path2$max_dewpoint, dewpoint_min=path2$min_dewpoint, dewpoint=path2$dewpoint, 
       humidity_max=path2$max_humidity,humidity_min=path2$min_humidity, humidity=path2$humidity, 
       precip=path2$precip_today, wind_dir=path2$wind_dir, wind_dir_max=path2$max_wind_dir, 
       wind_dir_degrees=path2$wind_dir_degrees, wind_dir_degrees_max=path2$max_wind_dir_degrees, 
       wind_speed_max=path2$max_wind_speed, wind_speed=path2$wind_speed,
       gust_dir_max=path2$max_gust_dir, gust_dir_degrees_max=path2$max_gust_dir_degrees, 
       wind_gust_speed_max=path2$max_wind_gust_speed,wind_gust_speed=path2$wind_gust_speed, 
       pressure_max=path2$max_pressure, pressure_min=path2$min_pressure, pressure=path2$pressure))
}
weather_pws = do.call(rbind,weather_pws)
weather_pws %>%
  mutate(date=as.Date(as.POSIXct(weather_pws$epoch, origin="1970-01-01"))) -> weather_pws
saveRDS(weather_pws,"weather_pws.rda")


weather_airport=list()
for (i in 1:length(airport_id_list)) {
  file=paste0("http://api.wunderground.com/api/606f3f6977348613/history_2018010120181231/units:metric/v:2.0/q/",airport_id_list[[i]],".json")
  json_data=fromJSON(file)
  
  path1=json_data$history$days$summary$date
  path2=json_data$history$days$summary
  
  try(weather_airport[[i]] <- tibble(airport_id=airport_id_list[[i]],epoch=path1$epoch, 
                                     temp_max=path2$max_temperature, temp_min=path2$min_temperature,temp=path2$temperature, 
                                     dewpoint_max=path2$max_dewpoint, dewpoint_min=path2$min_dewpoint, dewpoint=path2$dewpoint, 
                                     humidity_max=path2$max_humidity,humidity_min=path2$min_humidity,
                                     precip=path2$precip, 
                                     wind_dir=path2$wind_dir,  
                                     wind_dir_degrees=path2$wind_dir_degrees,
                                     wind_speed_max=path2$max_wind_speed, wind_speed=path2$wind_speed,
                                     pressure=path2$pressure))
}
weather_airport = do.call(rbind,weather_airport)
weather_airport %>%
  mutate(date=as.Date(as.POSIXct(weather_airport$epoch, origin="1970-01-01"))) -> weather_airport
saveRDS(weather_airport,"weather_airport.rda")
