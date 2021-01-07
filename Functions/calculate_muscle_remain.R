calculate_muscle_remain <- function(bodypart, z, scale) {
  
  # Given that we have calculated the quantity
  # required to meet bone requirements, how
  # much more muscle meat do we need to add
  # to meet that requirement?
  needed_weekly_oz_muscle <-
    hermes_stats %>% 
    filter(Part == "Muscle") %>% 
    pull(Weekly)
  
  musc_percent <-
    bone_db %>% 
    filter(Cut == {{ bodypart }}) %>% 
    pull(Meat)
  
  # Take the calculated OZ and now re-calculate how much
  # muscle meat that quantity of bodypart would provide.
  a1 <- round(z * musc_percent, digits = 1)
  
  # Calculate remaining quantity of muscle meat necessary
  # to reach weekly goal.
  a2 <- round(needed_weekly_oz_muscle - a1, digits = 1)
  
  if(scale == 'pounds') {
    a2 <- round(a2 * .0625, digits = 1)
  }
  
  return(paste0("You still need ", 
                a2, 
                " ",
                scale,
                " of muscle meat to meet your weekly quota."))
  
}
