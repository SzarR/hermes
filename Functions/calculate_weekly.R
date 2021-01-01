calculate_weekly <- function() {
  
  hermes_stats <-
    hermes_stats %>% 
    mutate(Weekly = Daily * 7) %>% 
    select(Part, Daily, Weekly, Scale)
  
}