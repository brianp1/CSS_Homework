

library(tidyverse)
library(httr)
library(stringr)
library(knitr)
library(curl)
library(purrr)

spotifyalbumURL <- "https://api.spotify.com/v1/artists/"
spotifyalbumsongsURL <- "https://api.spotify.com/v1/albums/{id}/tracks"



billboard20 <- data.frame(
  drake  = "https://play.spotify.com/artist/3TVXtAsR1Inumwj472S9r4",
  justin_bieber = "https://play.spotify.com/artist/1uNFoZAHBGtllmzznpCI3s", 
  twentyone_pilots = "https://play.spotify.com/artist/3YQKmKGau1PzlVlkL1iodx",
  chainsmokers ="https://play.spotify.com/artist/69GGBxA162lTqCwzJG5jLp", 
  rihanna = "https://play.spotify.com/artist/5pKCCKE2ajJHZ9KAiaK11H",
  adele = "https://play.spotify.com/artist/4dpARuHxo51G3z768sgnrY",
  shawn_mendes = "https://play.spotify.com/artist/7n2wHs1TKAczGzO7Dd2rGr",
  arianna_grande = "https://play.spotify.com/artist/66CXWjxzNUsdJxJ2JdwvnR",
  desiigner = "https://play.spotify.com/artist/7pFeBzX627ff0VnN6bxPR4",
  future = "https://play.spotify.com/artist/1RyvyyTE3xzB2ZywiAwp0i",
  bryson_tiller = "https://play.spotify.com/artist/2EMAnMvWE2eb56ToJVfCWs",
  fifth_harmony = "https://play.spotify.com/artist/1l8Fu6IkuTP0U5QetQJ5Xt",
  the_weekend = "https://play.spotify.com/artist/1Xyo4u8uXC1ZmMpatF05PJ",
  meghan_trainor = "https://play.spotify.com/artist/6JL8zeS1NmiOftqZTRgdTz", 
  sia = "https://play.spotify.com/artist/5WUlDfRSoLAfcVSX1WnrxN", 
  mike_posner = "https://play.spotify.com/artist/2KsP6tYLJlTBvSUxnwlVWa", 
  calvin_harris = "https://play.spotify.com/artist/7CajNmpbOovFoOoasH2HaY", 
  selena_gomez = "https://play.spotify.com/artist/0C8ZW7ezQVs4URX5aX7Kqx", 
  dnce = "https://play.spotify.com/artist/6T5tfhQCknKG4UnH90qGnz",
  charlie_puth = "https://play.spotify.com/artist/6VuMaDnrHyPL1p4EHjYLi7")

billboard20 <- billboard20 %>%
  gather("artists", "links") %>%
  mutate(id = substring(links, 33)) %>% 
  mutate(APIURL = str_c(spotifyalbumURL, id, "/albums"))

# get results using jsonlite
results <- map(billboard20$APIURL, fromJSON, flatten = TRUE)

# the json response from Spotify has lots of unnecessary info
# we only want to keep the element called "items" from the original
# response
results_clean <- vector("list", length(results))
for(artist in seq_along(results)){
  results_clean[[artist]] <- results[[artist]]$items
}

# the data is still not very clean - lets combine all the results into a single data frame
# and fix the artists column - currently it is stored as a list-column
results_clean <- results_clean %>%
  bind_rows() %>%
  tbl_df() %>%
  unnest(artists)

#essentially I need to figure out how to rename my columns
variablenum = c(1:13)
results_varnum = rbind(results_clean, variablenum)
split(results_varnum, )

#I then need to figure out a way to collapse 
