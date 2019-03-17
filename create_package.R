library(usethis)
usethis::create_package("stat290.finalproject")
use_vignette("weather_vignette")

location_city<-readRDS("location_city.rda")
weather_pws<-readRDS("weather_pws.rda")
pws<-readRDS("pws.rda")
airport<-readRDS("airport.rda")
weather_airport<-readRDS("weather_airport.rda")

usethis::use_data(location_city)
usethis::use_data(weather_pws)
usethis::use_data(pws)
usethis::use_data(airport)
usethis::use_data(weather_airport)

#source("get_map.R")
#source("distm_function.R")
#source("wind_rose_plot.R")
