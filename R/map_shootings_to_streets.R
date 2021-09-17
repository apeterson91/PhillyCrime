#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param shdf shootings dataframe
#' @param stdf streets dataframe
#' @return shootings mapped to streets
map_shootings_to_streets <- function(shdf, stdf) {

  
  gd <- shdf %>% 
    st_drop_geometry() %>% 
    mutate(Month = month(date_),
           Year = year(date_)) %>% 
    distinct(Year,Month) %>% 
    arrange(Year,Month) %>% 
    select(Year,Month)
  
  gd <- stdf %>%
    st_drop_geometry() %>% 
    select(street_ix,ST_NAME,ST_TYPE,
           SURFAWIDTH,MAPNAME) %>% 
    crossing(gd) %>% 
    inner_join(stdf %>% 
                 st_drop_geometry() %>% 
                 transmute(street_ix = 1:n()))
    
  ## TODO: need to include sensitivity check here
  shdf$street_ix <-  apply(st_distance(stdf,shdf),2,which.min) 
  
  out <- shdf %>% 
    st_drop_geometry() %>% 
    mutate(Year = year(date_),
           Month = month(date_)) %>% 
    group_by(Year,Month,street_ix) %>% 
    summarise(Y = n()) %>% 
    right_join(gd) %>% 
    mutate(Y = replace_na(Y,0)) %>% 
    ungroup() %>% 
    arrange(Year,Month,street_ix) %>% 
    
  
  return(out)

}
