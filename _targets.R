## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(

  tar_target(philly,read_in_philly_hoods()),
  
  tar_target(shdf,read_in_shootings_data(philly)),
  
  tar_target(stdf,read_in_streets(philly,shdf)),
  
  
  tar_target(stshdf,map_shootings_to_streets(shdf,stdf)),
  
  # need to add exposure, census tract covariates
  #tar_target(descriptive_table,tabulate_descriptives(stshdf)),
  
  tar_target(A,create_adjacency_matrix(stshdf,stdf)),
  
  tar_target(intercept_model,fit_intercept_model(stshdf,A))
)
