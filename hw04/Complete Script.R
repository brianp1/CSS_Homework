
dir.create("graphics")
dir.create("data")

#Downloading the Data Set

library(tidyverse)
library(downloader)
library(feather)


download(url = "http://football-data.co.uk/mmz4281/1314/D1.csv", destfile = "Germansoccer.csv")
#Downloaded 2013/2014 Bundesliga Match Day Stats
Bundesliga <- read.csv("Germansoccer.csv")
Bundesliga <- as_tibble(Bundesliga)
Bundesliga <- select(Bundesliga,`Div`:`AR`)
  
#Tidying Up the Data
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
#combined the variables
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

#Exploratory Analysis
TidyBundesliga %>%
  group_by(Team, Pts) %>%
  count() %>%
  mutate(Total = sum(Pts * n)) %>%
  group_by(Team) %>%
  summarise(Team, Total)
#Here is league standings


#Can we predict Results from the Half-Time Results
p <- TidyBundesliga %>%
ggplot(aes(HTGoalDif, GoalDif, color= HorA)) +
  facet_wrap(~HorA) +
  ggtitle("HT Results v Final Results")+
  geom_jitter() +
  geom_smooth()
ggsave("graphics/Figure1.png", p)

#What is the relationship between corners and goals scored?
q <- TidyBundesliga %>%
ggplot(aes(CornerFor, FTGF, color= Result)) +
 ggtitle("Goals & Corners") +
 geom_jitter() +
 geom_smooth()
ggsave("graphics/GoalsCorners.png", q)

y <- TidyBundesliga %>%
  filter(!(Result == "D")) %>%
  ggplot(aes(CornerFor, FTGF, color= Result)) +
  ggtitle("Goals & Corners2") +
  geom_jitter() +
  geom_smooth()
ggsave("graphics/GoalsCorners2.png", y)


