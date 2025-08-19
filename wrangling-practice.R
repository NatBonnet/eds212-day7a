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


#practice with lubridate
my_date <- "03-13-1998"
lubridate::mdy(my_date) #fixed yay

#format that date is in determines function used to fix
my_date <- "08-Jun-1974"
lubridate::dmy(my_date)

#another ex
my_date <- "19160518"
lubridate::ymd(my_date)

# what happens if we pass a date that makes no sense
lubridate::mdy("1942-08-30") #throws an error if its obviously wrong

lubridate::dmy("09/12/84") #have to be careful of the month and day format because you might actually not know

#working with date times
time <- "2020-8-12 11:18"
time <- lubridate::ymd_hm(time, tz = "America/Los_Angeles") #naming time zone

#convert to PST
with_tz(time, "America/Los_Angeles")

# can extract information from dates
week(time)
year(time)
day(time)

start_time <- Sys.time()
end_time <- Sys.time()
end_time - start_time #can see how long it took for R to run
