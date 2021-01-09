# Meta-Information --------------------------------------------------------

# Script name: hermes.R 
# Purpose of script: Get Hermes Macro Nutrition Counts
# Author: Robert W. Szarek
# Date Created: 1/1/2021
# Email: szarekr@gmail.com

# Options and Packages ----------------------------------------------------

library(tidyverse)

# Custom Functions --------------------------------------------------------

source(file = "~/R-lang/hermes/Functions/calculate_bone.R")
source(file = "~/R-lang/hermes/Functions/calculate_muscle.R")
source(file = "~/R-lang/hermes/Functions/calculate_muscle_remain.R")
source(file = "~/R-lang/hermes/Functions/calculate_weekly.R")

# Load Required Datasets --------------------------------------------------

# CSV file containing daily ounce of various nutritional targets.
hermes_stats <- readr::read_csv(file = "~/R-lang/hermes/hermes_stats")

# database file of how much % bone / %  muscle in various animals.
bone_db <- readr::read_csv(file = "~/R-lang/hermes/data/bone_db")

# Get weekly counts
hermes_stats <- calculate_weekly()


# Step 0: Specify Body Part -----------------------------------------------

animal <- c("Turkey Neck")

# Step 1: Get Bone Calculation --------------------------------------------
calculate_bone(bodypart = animal,
               frequency = "Daily",
               scale = "ounces")

# Step 2: Get Muscle Calculation ------------------------------------------
calculate_muscle_remain(bodypart = animal,
                       frequency = "Daily",
                       z = 4.8, 
                       scale = 'ounces')

calculate_muscle(bodypart = animal,
                 z = 4.8,
                 scale = 'ounces')
