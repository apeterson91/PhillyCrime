#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param philly
read_in_streets <- function(philly,shootings) {

  streets <- read_sf("~/Documents/CityData/Philly/CompleteStreets-shp/CompleteStreets.shp") %>% 
    st_join(philly %>% select(MAPNAME)) %>% 
    mutate(street_ix = 1:n())
  
  
  return(streets)
}
