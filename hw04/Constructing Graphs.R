#Constructing Graphs
read_feather("data/FullBundesliga.feather")

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