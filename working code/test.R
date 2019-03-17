library(stat290.finalproject)

?history_weather
c="Alameda"
d1="2018-06-01"
d2="2018-12-31"
history_weather_tbl=history_weather(city_name = c,start_date=d1,end_date=d2)
head(history_weather_tbl)

?nearby_pws_city
pws_id_selected <- nearby_pws_city(city_name = "Alameda",check_date="2018-05-05")
head(pws_id_selected)

?nearby_pws_coordinates
l1=-122.27999878
l2=37.52000046
dis=4000
d="2018-05-05"
pws_id_selected=nearby_pws_coordinates(lon=l1,lat=l2,distance = dis,data="pws.rda",check_date = d)
head(pws_id_selected)

?weather_map
pws_id_selected <- nearby_pws_city(city_name = "Alameda",check_date="2018-05-05")
weather_map(df=pws_id_selected)

?history_temp_daily
d1="2018-06-01"
d2="2018-12-31"
city="Alameda"
history_weather_tbl=history_weather(city_name = city,start_date=d1,end_date=d2)
history_humidity_month(df=history_weather_tbl)


?history_temp_month
d1="2018-06-01"
d2="2018-12-31"
city="Alameda"
history_weather_tbl=history_weather(city_name = city,start_date=d1,end_date=d2)
history_humidity_month(df=history_weather_tbl)

?history_humidity_daily
d1="2018-06-01"
d2="2018-12-31"
city="Alameda"
history_weather_tbl=history_weather(city_name = city,start_date=d1,end_date=d2)
history_humidity_month(df=history_weather_tbl)

?history_humidity_month
d1="2018-06-01"
d2="2018-12-31"
city="Alameda"
history_weather_tbl=history_weather(city_name = city,start_date=d1,end_date=d2)
history_humidity_month(df=history_weather_tbl)

?weather_windrose
df=history_weather(city_name = "Alameda",start_date="2018-06-01",end_date="2018-12-31")
weather_windrose(data = df, spd = "wind_speed", dir = "wind_dir_degrees")

?weather_ui
library(shiny)
runApp('shiny_code.R')

