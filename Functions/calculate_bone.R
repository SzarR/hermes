calculate_bone <- function(bodypart, frequency="Weekly", scale = "ounce") {
  
  # Extract needed weekly requirement in ounces.
  needed_weekly_oz_bone <-
    hermes_stats %>% 
    filter(Part == "Bone") %>% 
    pull(Weekly)
  
  bone_percent <-
    bone_db %>% 
    filter(Cut == {{ bodypart }}) %>% 
    pull(Bone)
  
  # Calculate how many oz of bodypart required to meet the
  # weekly bone goal outlined in hermes_stats
  x <- round(needed_weekly_oz_bone / bone_percent, digits = 1)

  return(paste0("You'll need "
                , x
                , 
                " ounces of ",
                bodypart, " to meet your weekly bone quota."))
  return(x)

}
