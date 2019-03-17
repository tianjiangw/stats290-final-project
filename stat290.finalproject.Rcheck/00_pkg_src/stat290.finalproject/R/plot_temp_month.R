#' Plot_temperature_monthly
#'
#' @description plot historical temperature by month
#'              1) Mean temperature
#'              2) Max temperature
#'              3) Min temperature
#' @export
#'
#' @param df complex
#'
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
#' history_temp_month(df=history_weather_tbl)
#'}
#'
#' @keywords temperature by month
#'
#'
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
