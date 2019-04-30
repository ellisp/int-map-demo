library(absmapsdata)
library(Census2016.DataPack)
library(data.table)
library(tidyverse)

school_sa4 <- SA4__Age_MaxSchoolingCompleted_Sex %>%
  group_by(SA4_NAME16, Age, MaxSchoolingCompleted) %>%
  summarise(adults = sum(adults))

school_sa4_sum <- school_sa4 %>%
  group_by(SA4_NAME16) %>%
  summarise(prop_yr10_below = sum(adults[MaxSchoolingCompleted %in% c("Did not go to school",
                                                "Year 8 or below",
                                                "Year 9",
                                                "Year 10")]) / 
              sum(adults[!is.na(MaxSchoolingCompleted)])) %>%
  left_join(sa42016, by = c("SA4_NAME16" = "sa4_name_2016"))



save(school_sa4, file = "shiny-map/data/school_sa4.rda")
save(school_sa4_sum, file = "shiny-map/data/school_sa4_sum.rda")

  

