library(shiny)
library(tidyverse)
library(tidytext)
library(rvest)
library(feather)
library(stringr)




get_Trump_speeches <- function(x){
  text_url = str_c("http://www.presidency.ucsb.edu/ws/index.php?pid=", x)
  
  df1 <- read_html(text_url) %>%
    html_nodes("p") %>%
    html_text()
  
  df2 <- read_html(text_url)%>%
    html_node(".docdate")%>%
    html_text()
  
  
  speech <- data_frame(text = df1) %>%
    mutate(author = "Trump",
           parnumber = row_number(),
           date = df2) %>%
    separate(date, into = c("date2", "year"), sep = ",") %>%
    separate(date2, into = c("month", "day"), sep = " ")
  speech <- unnest_tokens(speech, word, text, token = "words")  
  return(speech)
}  

x = c(
  "119182",  
  "119181",
  "119188",
  "119187",
  "119186",  
  "119185",  
  "119184",  
  "119183",
  "119174",
  "119172",  
  "119180",  
  "119173",  
  "119170",  
  "119169",  
  "119168",  
  "119167",  
  "119166",  
  "119179",  
  "119202",  
  "119201",  
  "119200",  
  "119203",  
  "119191",  
  "119189",  
  "119192",  
  "119207",  
  "119208",  
  "119209", 
  "119190",  
  "119206",  
  "119206",  
  "119193",  
  "119205",  
  "119178",  
  "119204",  
  "119194",  
  "119195",  
  "119177",  
  "119197",  
  "119199",  
  "119198",  
  "119196",  
  '119176',  
  "119175",  
  "119165",  
  "119503",  
  "117935",  
  "117791",  
  "117815",  
  "117790",  
  "117775",  
  "117813",  
  "116597")

Trump_Corpus <- map_df(x, get_Trump_speeches, .id = "docnumber")


get_Clinton_speeches <- function(x){
  text_url = str_c("http://www.presidency.ucsb.edu/ws/index.php?pid=", x)
  
  df1 <- read_html(text_url) %>%
    html_nodes("p") %>%
    html_text()
  
  df2 <- read_html(text_url)%>%
    html_node(".docdate")%>%
    html_text()
  
  
  speech <- data_frame(text = df1) %>%
    mutate(author = "Clinton",
           parnumber = row_number(),
           date = df2) %>%
    separate(date, into = c("date2", "year"), sep = ",") %>%
    separate(date2, into = c("month", "day"), sep = " ")
  speech <- unnest_tokens(speech, word, text, token = "words")  
  return(speech)
}


h <- c("119498",
       "119502",
       "119501",
       "119500",
       "119499",
       "119497",
       "119157",
       "119156",
       "119155",
       "119154",
       "119153",
       "119152",
       "119151",
       "119150",
       "119149",
       "119164",
       "119163",
       "119162",
       "119161",
       "119160",
       "119159",
       "119158",
       "119148",
       "118051",
       "119295",
       "116600",
       "111596",
       "111439",
       "111414",
       "111415",
       "119292",
       "111418",
       "111419",
       "110267",
       "110269",
       "110268")

Clinton_Corpus <- map_df(h, get_Clinton_speeches, .id = "docnumber")


get_Sanders_speeches <- function(x){
  text_url = str_c("http://www.presidency.ucsb.edu/ws/index.php?pid=", x)
  
  df1 <- read_html(text_url) %>%
    html_nodes("p") %>%
    html_text()
  
  df2 <- read_html(text_url)%>%
    html_node(".docdate")%>%
    html_text()
  
  
  speech <- data_frame(text = df1) %>%
    mutate(author = "Sanders",
           parnumber = row_number(),
           date = df2) %>%
    separate(date, into = c("date2", "year"), sep = ",") %>%
    separate(date2, into = c("month", "day"), sep = " ")
  speech <- unnest_tokens(speech, word, text, token = "words")  
  return(speech)
}  

s <- c("118045", 
       "117194", 
       "117513", 
       "116694", 
       "117516", 
       "117511", 
       "111440", 
       "117514", 
       "117512", 
       "114496", 
       "114487", 
       "117517", 
       "114493", 
       "114491", 
       "114486", 
       "114488", 
       "114494") 

Sanders_Corpus <- map_df(s,get_Sanders_speeches, .id = "docnumber")


get_Repub_speeches <- function(x){
  text_url = str_c("http://www.presidency.ucsb.edu/ws/index.php?pid=", x)
  
  df1 <- read_html(text_url) %>%
    html_nodes("p") %>%
    html_text()
  
  df2 <- read_html(text_url)%>%
    html_node(".docdate")%>%
    html_text()
  
  
  speech <- data_frame(text = df1) %>%
    mutate(author = "Cruz/Kasich/Rubio",
           parnumber = row_number(),
           date = df2) %>%
    separate(date, into = c("date2", "year"), sep = ",") %>%
    separate(date2, into = c("month", "day"), sep = " ")
  speech <- unnest_tokens(speech, word, text, token = "words")  
  return(speech)
}  

r <- c("118041",
       "117232",
       "116598",
       "114768",
       "111441",
       "116599",
       "113069")

Repub_Corpus <- map_df(r, get_Repub_speeches, .id = "docnumber")

total_tokens <- bind_rows(Clinton_Corpus, Repub_Corpus, Sanders_Corpus, Trump_Corpus)

total_tokens <- total_tokens %>%
  inner_join(get_sentiments("afinn"))
total_tokens <- total_tokens %>%
  group_by(author) %>%
  mutate(word_length = nchar(word))
total_tokens <- total_tokens %>%
  mutate(year = str_trim(year))

write_feather(total_tokens, "App/total_tokens.feather")

