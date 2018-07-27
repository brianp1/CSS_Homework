#Tidying up the Data Set

library(tidyverse)
library(feather)
Home <- Bundesliga %>%
  select(-AwayTeam)
#extracted the Away team
Away <- Bundesliga %>%
  select(-HomeTeam)
#extracted the Home team
Home <- Home %>%
  rename(Team = HomeTeam,
         FTGF = FTHG,
         FTGA = FTAG,
         HTGF = HTHG,
         HTGA = HTAG,
         ShotsFor = HS,
         ShotsAgainst = AS,
         ShotsTarget = HST,
         OPShotsTarget = AST,
         Fouls = HF,
         OPFouls = AF,
         CornerFor = HC,
         CornerAgainst = AC,
         Yellow = HY,
         OPYellow = AY,
         Red = HR,
         OPRed = AR) %>%
  mutate(HorA = "H")
#renamed the variables to have 'for' meaning the Home team and 'against' meaning the away team
#created a new column to indicate that these teams were the home team
Away <- Away %>%
  rename(Team = AwayTeam,
         FTGF = FTAG,
         FTGA = FTHG,
         Result = FTR,
         HTGF = HTAG,
         HTGA = HTHG,
         HTResult = HTR,
         ShotsFor = AS,
         ShotsAgainst = HS,
         ShotsTarget = AST,
         OPShotsTarget = HST,
         Fouls = AF,
         OPFouls = HF,
         CornerFor = AC,
         CornerAgainst = HC,
         Yellow = AY,
         OPYellow = HY,
         Red = AR,
         OPRed = HR) %>%
  mutate(HorA = "A")
#renamed the varaibles so this time 'for' mean the Away team and 'against' mean the Home team
#created a column to indicate that these were the Away teams
TidyBundesliga <- bind_rows(Home, Away)

write_feather(TidyBundesliga, "hw04/data")


