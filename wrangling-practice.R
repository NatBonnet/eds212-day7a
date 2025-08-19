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

animals <- data.frame(
  stringsAsFactors = FALSE,
          location = c("lagoon", "bluff", "creek", "oaks", "bluff"),
           species = c("bobcat", "coyote", "fox", "squirrel", "bobcat"),
          maturity = c("adult", "juvenile", "adult", "juvenile", "adult")
)


sites <- data.frame(
  stringsAsFactors = FALSE,
          location = c("beach", "lagoon", "bluff", "oaks"),
    full_site_name = c("Goleta Beach","UCSB Lagoon",
                       "Ellwood Mesa","Fremont Campground"),
      jurisdiction = c("SB City", "UCSB", "SB City", "USFS")
)

# practicing join

#practice with a full join- keeps all rows and adds all columns
full_join(animals, sites)

#left join- keeps only the rows tha are shared in by y with x
left_join(animals, sites)

#right join-the opposite 
right_join(animals, sites)

#inner join- no NAs
inner_join(animals, sites)


#filtering joins

#semi join
semi_join(animals, sites)
#same as
animals |> filter(location %in% sites$location)

#anti-join
anti_join(animals, sites)
#same as
animals |> filter(!location %in% sites$location)