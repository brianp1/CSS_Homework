#Constructing League Standings Table
read_feather("data/FullBundesliga.feather")

#Exploratory Analysis
TidyBundesliga %>%
  group_by(Team, Pts) %>%
  count() %>%
  mutate(Total = sum(Pts * n)) %>%
  group_by(Team) %>%
  summarise(Team, Total)
  #Here is league standings
  #Finish making the table
  