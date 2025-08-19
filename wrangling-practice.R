#clear env
rm(list=ls())

library(tidyverse)
library(palmerpenguins)
library(lubridate)


#Data wrangling refresh
#only include penguins at Briscoe and Dream Islands, remove year and sex cols, add a new column called body_mass_kg with penguin mass converted from g to kg, then rename the island variable to location
penguins1 <- palmerpenguins::penguins |> filter(island == "Biscoe" | island == "Dream") |> 
  select(-year, -sex) |>
  mutate(body_mass_kg = body_mass_g/1000) |>
  rename(location = island)
  
  
penguins_adelie <- palmerpenguins::penguins |> filter(species == "Adelie") |>
  filter(!is.na(flipper_length_mm), !is.na(sex)) |> #removing rows that are not NA
  group_by(sex)|>
  summarize(mean_flipper = mean(flipper_length_mm), sd_flipper = sd(flipper_length_mm), sample_size = n())

