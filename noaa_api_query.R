library(rnoaa)
options(noaakey = "XXXXXXXXX") # request token here: https://www.ncdc.noaa.gov/cdo-web/token

# Limit is 1000 entries so have to do half a year at a time
# and also repeat for each of 4 years 2016 - 2019

# the following is an example of how to get
# avg monthly temperatures for the first half of 
# 2019 in New York

NY_temp_raw_jan_jun <- ncdc(datasetid = 'GSOM',
                            datatypeid = 'TAVG', 
                            locationid = "FIPS:36", 
                            startdate = '2019-01-01',
                            enddate = '2019-06-30', 
                            limit = 1000,
                            add_units = TRUE) 

NY_temp_2019_jan_jun <- NY_temp_raw_jan_jun$data %>% 
  as.data.frame() %>%
  group_by(date) %>% 
  summarise(mean = mean(value, na.rm = TRUE)) %>%
  mutate(date = 1:6) %>%
  rename(amonth = date) %>%
  mutate(year = 2019)
