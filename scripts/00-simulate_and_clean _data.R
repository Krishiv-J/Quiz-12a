#### Preamble ####
# Purpose: Simulates cancer death data
# Author: Krishiv Jain
# Date: 30/03/24
# Contact: krishiv.jain@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(555) #random seed

hospital_names <- c("SRAH", "San", "Mater", "St. Vincent", "Royal")

simulated_data <- 
  tibble(
  Hospital = rep(hospital_names, each = 21),
  Year = rep(seq(2003, 2023), length(hospital_names)),
  Deaths = round(runif(105, min = 0, max = 1000)),
  Average_Smoking_Rate = runif(105, min = 0, max = 100),
  Average_Income = runif(105, min = 70000, max = 150000),
  Average_Alcohol_Consumption = runif(105, min = 0, max = 100))

### TESTS ###


##Check the minimum number is equal, or greater than, 0 ##
#Based on: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html#simulate
simulated_data$Average_Smoking_Rate |> min() >= 0
simulated_data$Average_Alcohol_Consumption |> min() >= 0

##Check the percent is not higher than 100 ##
simulated_data$Average_Smoking_Rate |> max() <= 100
simulated_data$Average_Alcohol_Consumption |> max() <= 100

# Check that there are exactly 105 data points
length(simulated_data$Hospital) == 105

##Check the class of the column is numeric##
simulated_data$Average_Smoking_Rate |> class() == "numeric"
simulated_data$Average_Alcohol_Consumption |> class() == "numeric"
simulated_data$Average_Income |> class() == "numeric"
simulated_data$Deaths |> class() == "numeric"

## Check that the columns only have whole numbers ##
#Based on: https://stackoverflow.com/q/3476782/23271634
is.wholenumber <- function(x, tol = .Machine$double.eps^0.5) abs(x - round(x)) < tol
is.wholenumber(simulated_data$Deaths)