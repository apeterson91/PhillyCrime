#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

read_in_shootings_data <- function(philly) {

  shootings <- read_csv("~/Documents/CityData/Philly/Crime/shootings_2015_2020.csv") %>% 
    filter(!is.na(point_x),!is.na(point_y)) %>% 
    filter(officer_involved=="N") %>% 
    st_as_sf(coords = c("lng","lat")) %>% 
    st_set_crs(4326) %>% 
    select(date_,time,race,sex,age,wound,
           offender_injured,latino,outside,inside,fatal) %>% 
    st_join(philly %>% select(MAPNAME)) %>% 
    mutate(Month = month(date_),
           Year = year(date_)) 
  
  return(shootings)
  
}
