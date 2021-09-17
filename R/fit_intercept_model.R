#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param stshdf
#' @param A
fit_intercept_model <- function(stshdf, A) {

  fit <- brm(Y ~ 1 + car(A,gr = street_ix, type = "bym2"),
             data = stshdf %>% filter(Year == 2015,Month == 1),  
             data2 = list(A = A),
             family = zero_inflated_poisson(),
             chains = 2, iter = 2E3,
             backend = "cmdstanr",
             threads = threading(2),
             )

}
