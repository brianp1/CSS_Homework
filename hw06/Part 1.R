library(geonames) 
library(tidyverse)
library(knitr)
library(gapminder)
library(countrycode)


countryInfo <- GNcountryInfo()

countryInfo %>%
  tbl_df()%>%
  head()

countryInfo <- countryInfo %>%
  transform(areaInSqKm = as.numeric(areaInSqKm))



fulldata <- gapminder %>%
  mutate(countryCode = countrycode(gapminder$country, "country.name", "iso2c")) %>%
  left_join(countryInfo[2:17]) %>%
  mutate(popden = pop/areaInSqKm)

fulldata %>%
ggplot(aes(popden, lifeExp)) +
  geom_point(alpha = .2) +
  geom_smooth() +
  scale_x_log10() +
  labs(title = "As population  density increases, life expectancy increases",
       x = "Population Density",
       y = "Average life expectancy")

