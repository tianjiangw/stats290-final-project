#' Plot_humidity_monthly
#'
#' @description plot historical humidity by month
#'              1) Mean humidity
#'              2) Max humidity
#'              3) Min humidity
#' @export
#'
#' @param df complex
#' @param history_weather_tbl parameter
#' @importFrom magrittr %>%
#' @importFrom dplyr filter select inner_join group_by summarise
#' @importFrom tidyr gather
#' @importFrom ggplot2 aes scale_x_discrete ggtitle geom_line
#'
#' @examples
#' \dontrun{
#' d1="2018-06-01"
#' d2="2018-12-31"
#' city="Alameda"
#' history_weather_tbl=history_weather(city_name = city,start_date=d1,end_date=d2)
#' history_humidity_month(df=history_weather_tbl)
#' }
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


