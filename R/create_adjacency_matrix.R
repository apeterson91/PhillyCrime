#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

create_adjacency_matrix <- function(stshdf,stdf) {

  
  ntdf <- sfnetworks::as_sfnetwork(stshdf %>% 
                                     filter(Year == 2015, Month == 1) %>% 
                                     left_join(stdf %>% 
                                                 transmute(street_ix = 1:n())) %>% 
                                     st_as_sf() %>% select(street_ix),
                                   directed = F)
  
  A <- ntdf %>% 
    tidygraph::convert(tidygraph::to_linegraph) %>% 
    tidygraph::activate(edges) %>% 
    distinct(from,to) %>% 
    igraph::as_adjacency_matrix()
  
  rownames(A) <- stshdf %>% filter(Year == 2015,
                                   Month == 1 ) %>% 
    pull(street_ix)
  
  return(A)

}
