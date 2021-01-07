calculate_muscle <- function(bodypart, z, scale = "ounces") {
  
  # Given that we have calculated the quantity
  # required to meet bone requirements, how
  # much more muscle meat do we need to add
  # to meet that requirement?
  
  musc_percent <-
    bone_db %>% 
    filter(Cut == {{ bodypart }}) %>% 
    pull(Meat)
  
  # Take the calculated OZ and now re-calculate how much
  # muscle meat that quantity of bodypart would provide.
  a1 <- round(z * musc_percent, digits = 1)
  
  if(scale == 'pounds') {
    a1 <- round(a1 * .0625,digits = 1)
  }
  
  # Calculate remaining quantity of muscle meat necessary
  # to reach weekly goal.

  return(paste0("The ", 
                bodypart,
                " provides ",
                a1, 
                " ",
                scale,
                " of muscle meat to meet your weekly muscle quota."))
  
}