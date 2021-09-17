

plot_seasonal_spatial_counts <- function(stshdf,philly){
  
  pltdf <- stshdf %>% 
    st_drop_geometry() %>% 
    mutate(Season = factor(case_when(Month %in% c(12,1:3) ~ "Winter",
                                     Month %in% c(4:6) ~ "Spring",
                                     Month %in% c(7:9) ~ "Summer",
                                     Month %in% 10:11 ~ "Fall"),
                           levels = c("Winter","Spring","Summer",
                                      "Fall"))
    ) %>% 
    group_by(MAPNAME,Year,Season) %>% 
    summarise(Y = sum(Y)) %>% 
    ungroup()
  
  ## animate across time ?
  p <- pltdf %>% 
    filter(Year %in% 2019:2020) %>% 
    left_join(philly %>% 
                select(MAPNAME)) %>% 
    st_as_sf() %>% 
    ggplot() + 
    geom_sf(aes(color = Y)) + 
    theme_void() + 
    theme(legend.title = element_blank()) +  
    scale_colour_gradientn(colours = c("white","yellow","red")) + 
    facet_grid(Year ~ Season)
  
  
    ggsave("Figures/seasonal_map_plot.pdf",p,width = 14, height = 8)
    
    return("Figures/seasonal_map_plot.pdf")
  
}