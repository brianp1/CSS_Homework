#Constructing Varaibles we need from current variables
read_feather("data/TidyBundesliga.feather")

TidyBundesliga <- TidyBundesliga %>%
  mutate(Result = ifelse(FTGF > FTGA, "W",
                         ifelse(FTGF < FTGA, "L","D"))) %>%
  mutate(HTResult = ifelse(HTGF > HTGA, "W",
                           ifelse(HTGF < HTGA, "L","D"))) %>%
  mutate(Pts = ifelse(`Result` == "W", 3,
                      ifelse(`Result` == "L", 0, 1))) %>%
  mutate(GoalDif = FTGF - FTGA) %>%
  mutate(HTGoalDif = HTGF - HTGA) 
#The results column does not provide us no infomration now that we have extracted Home/Away
#Created a new column in order to determine if the team won, lost, or drew that game
#Created a Goal Difference variable
TidyBundesliga <- TidyBundesliga %>%
  select(-FTR, -HTR)
#took out the columns we no longer need

write_feather(TidyBundesliga, "data/FullBundesliga.feather")
