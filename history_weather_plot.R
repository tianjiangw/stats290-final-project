library(dplyr)
library(tidyr)
library(ggplot2)

##temperature by month
history_temp_month <- function(df=history_weather_tbl) {
  df %>% group_by(month) %>%
    summarise(min_temperature = median(temp_min, na.rm = TRUE),
              max_temperature = median(temp_max, na.rm = TRUE),
              avg_temperature = median(temp,na.rm = TRUE)) %>%
    gather(metric, temperature, -month) %>%
    ggplot(.,aes(x = month, y = temperature, 
                 group = metric, color = metric)) + 
    scale_x_discrete(limits=df$month) + 
    ggtitle(paste0("Historical Weather - ",unique(df$location_city)," (",min(df$date),"~",max(df$date),")")) +
    geom_line()
}

##history_temp_month(data=history_weather_tbl)

##temperature by date
history_temp_daily <- function(df=history_weather_tbl) {
  df %>% group_by(date) %>%
  summarise(min_temperature = median(temp_min, na.rm = TRUE),
            max_temperature = median(temp_max, na.rm = TRUE),
            avg_temperature = median(temp,na.rm = TRUE)) %>%
  gather(metric, temperature, -date) %>%
  ggplot(.,aes(x = date, y = temperature, 
               group = metric, color = metric)) +  
  scale_x_date(date_labels="%b %y",date_breaks  ="1 month") +
  ggtitle(paste0("Historical Weather - ",unique(df$location_city)," (",min(df$date),"~",max(df$date),")")) +
  geom_line()
}


##humidity by month
history_humidity_month <- function(df=history_weather_tbl) {
  df %>% group_by(month) %>%
  summarise(min_humidity = median(humidity_min, na.rm = TRUE),
            max_humidity = median(humidity_max, na.rm = TRUE),
            avg_humidity = median(humidity,na.rm = TRUE)) %>%
  gather(metric, humidity, -month) %>%
  ggplot(.,aes(x = month, y = humidity, 
               group = metric, color = metric)) + 
  scale_x_discrete(limits=df$month) + 
  ggtitle(paste0("Historical Weather - ",unique(df$location_city)," (",min(df$date),"~",max(df$date),")")) +
  geom_line()
}

##humidity by date
history_humidity_daily <- function(df=history_weather_tbl) {
  df %>% group_by(date) %>%
  summarise(min_humidity = median(humidity_min, na.rm = TRUE),
            max_humidity = median(humidity_max, na.rm = TRUE),
            avg_humidity = median(humidity,na.rm = TRUE)) %>%
  gather(metric, humidity, -date) %>%
  ggplot(.,aes(x = date, y = humidity, 
               group = metric, color = metric)) +  
  scale_x_date(date_labels="%b %y",date_breaks  ="1 month") +
  ggtitle(paste0("Historical Weather - ",unique(df$location_city)," (",min(df$date),"~",max(df$date),")")) +
  geom_line()
}