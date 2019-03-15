#' Plot_temperature_daily
#'
#' @description plot historical temperature by date
#'              1) Mean temperature
#'              2) Max temperature
#'              3) Min temperature
#' @export
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr filter select inner_join group_by summarise
#' @importFrom tidyr gather
#' @importFrom ggplot2 aes scale_x_discrete ggtitle geom_line
#'
#' @examples
#' history_weather_tbl=history_weather(city_name = "Alameda",start_date="2018-06-01",end_date="2018-12-31")
#' history_temp_daily(data=history_weather_tbl)
#' @keywords temperature by date
#'
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

