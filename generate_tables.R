myVars <- c("age", "gender", "race", "pay1", "pl_nchs","season", "tran_in","aweekend","died","elective", "zipinc_qrtl")

tab1 <- CreateTableOne(vars = myVars, 
                       strata = "los", 
                       data = asthma_data %>% 
                         filter(hosp_division == "Middle Atlantic") %>%
                         filter(age >1) %>%
                         filter(los < 10) %>%
                         filter(asthma_DRG == 1) %>%
                         mutate(los = ifelse(los < 5, "<5", ">5")) %>%
                         mutate(season = ifelse(amonth == 12 | amonth == 1 | amonth == 2, "winter",
                                                ifelse(amonth == 3 | amonth == 4 | amonth == 5, "spring",
                                                       ifelse(amonth == 6 | amonth == 7 | amonth == 8, "summer",
                                                              ifelse(amonth == 9 | amonth == 10 | amonth == 11, "fall",""))))) %>%
                         select(age, gender, race, pay1, pl_nchs, season, tran_in, aweekend, died, elective, zipinc_qrtl, los) %>%
                         mutate(zipinc_qrtl = as.character(zipinc_qrtl)) %>%
                         mutate(pay1 = as.character(pay1)) %>%
                         mutate(pl_nchs = as.character(pl_nchs)) %>%
                         mutate(season = as.character(season)) %>%
                         mutate(tran_in = as.character(tran_in)) %>%
                         mutate(aweekend = as.character(aweekend)) %>%
                         mutate(died = as.character(died)) %>%
                         mutate(elective = as.character(elective))%>%
                         mutate(age = ifelse(age<18, "1",
                                             ifelse(age>=18 & age <30, "2",
                                                    ifelse(age>=30 & age<50, "3", 
                                                           ifelse(age>=50 & age<65, "4", 
                                                                  ifelse(age >=65, "5", "NA")))))))

print(tab1, showAllLevels = TRUE, nonformatOptions = list(big.mark = ","))
