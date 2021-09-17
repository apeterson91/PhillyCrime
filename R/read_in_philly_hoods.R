#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

read_in_philly_hoods <- function() {

  out <- read_sf("~/Documents/CityData/Philly/geo-data/Neighborhoods_Philadelphia/Neighborhoods_Philadelphia.shp") %>% 
      st_transform(4326)
  
  return(out)
}
