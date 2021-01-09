calculate_bone <- function(bodypart, frequency="Weekly", scale = "ounces") {
  
  # Extract needed weekly requirement in ounces.
  needed_weekly_oz_bone <-
    hermes_stats %>% 
    filter(Part == "Bone") %>% 
    pull({{ frequency }})
  
  bone_percent <-
    bone_db %>% 
    filter(Cut == {{ bodypart }}) %>% 
    pull(Bone)
  
  # Calculate how many oz of bodypart required to meet the
  # weekly bone goal outlined in hermes_stats
  x <- round(needed_weekly_oz_bone / bone_percent, digits = 1)
  
  if(scale == 'pounds') {
    x <- round(x * .0625, digits = 1)
  }

  return(paste0("You'll need ",
                x,
                " ",
                scale,
                " of ",
                bodypart, " to meet your ",
                frequency,
                " bone quota."))
  return(x)

}
