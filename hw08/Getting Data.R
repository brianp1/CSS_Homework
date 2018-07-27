library(tidyverse)
library(tidytext)
library(rvest)
library(stringr)
library(caret)
library(randomForest)
library(tm)
library(knitr)
library(tree)
library(feather)


get_Clinton_speeches <- function(x, y){
  df1 <- read_html(x) %>%
    html_nodes("p") %>%
    html_text()
  
  df2 <- read_html(x)%>%
    html_node(".docdate")%>%
    html_text()
  
  
  speech <- data_frame(text = df1) %>%
    mutate(author = "Clinton",
           docnumber = y,
           parnumber = row_number(),
           date = df2) %>%
    separate(date, into = c("day/month", "year"), sep = ",")
  speech <- unnest_tokens(speech, word, text, token = "words")  
  return(speech)
}  

?spread

#2016 Clinton Presidential Campaign Speeches
#Clinton1 is Nov 3, 2016 - Clinton31 is Dec 15, 2015 
Clinton1 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119498", "1")
Clinton2 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119502", "2")
Clinton3 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119501", "3")
Clinton4 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119500", "4")
Clinton5 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119499", "5")
Clinton6 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119497", "6")
Clinton7 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119157", "7")
Clinton8 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119156", "8")
Clinton9 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119155", "9")
Clinton10 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119154", "10")
Clinton11 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119153", "11")
Clinton12 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119152", "12")
Clinton13 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119151", "13")
Clinton14 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119150", "14")
Clinton15 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119149", "15")
Clinton16 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119164", "16")
Clinton17 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119163", "17")
Clinton18 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119162", "18")
Clinton19 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119161", "19")
Clinton20 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119160", "20")
Clinton21 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119159", "21")
Clinton22 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119158", "22")
Clinton23 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119148", "23")
Clinton24 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=118051", "24")
Clinton25 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119295", "25")
Clinton26 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=116600", "26")
Clinton27 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=111596", "27")
Clinton28 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=111439", "28")
Clinton29 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=111414", "29")
Clinton30 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=111415", "30")
Clinton31 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119292", "31")
Clinton32 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=111418", "32")
Clinton33 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=111419", "33")
Clinton34 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=110267", "34")
Clinton35 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=110269", "35")
Clinton36 <- get_Clinton_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=110268", "36")

Clinton_Corpus <- bind_rows(Clinton1, Clinton2, Clinton3, Clinton4, Clinton5, Clinton6, Clinton7, Clinton8, Clinton9, Clinton10, Clinton11, Clinton12, Clinton13, Clinton14, Clinton15, Clinton16, Clinton17, Clinton18, Clinton19, Clinton20, Clinton21, Clinton22, Clinton23, Clinton24, Clinton25, Clinton26, Clinton27, Clinton28, Clinton29, Clinton30, Clinton31, Clinton32, Clinton33, Clinton34, Clinton35, Clinton36)

get_speeches <- function(x, y, z){
  df1 <- read_html(x) %>%
    html_nodes("p") %>%
    html_text()
  
  df2 <- read_html(x)%>%
    html_node(".docdate")%>%
    html_text()
  
  speech <- data_frame(text = df1) %>%
    mutate(author = y,
           docnumber = z,
           parnumber = row_number(),
           date = df2) %>%
    separate(date, into = c("day/month", "year"), sep = ",")
  speech <- unnest_tokens(speech, word, text, token = "words")  
  return(speech)
}  

#2016 Sanders Presidential Campaign Speeches
Sanders1 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=118045", "Sanders", "1")
Sanders2 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117194", "Sanders", "2")
Sanders3 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117513", "Sanders", "3")
Sanders4 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=116694", "Sanders", "4")
Sanders5 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117516", "Sanders", "5")
Sanders6 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117511", "Sanders", "6")
Sanders7 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=111440", "Sanders", "7")
Sanders8 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117514", "Sanders", "8")
Sanders9 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117512", "Sanders", "9")
Sanders10 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=114496", "Sanders", "10")
Sanders11 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=114487", "Sanders", "11")
Sanders12 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117517", "Sanders", "12")
Sanders13 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=114493", "Sanders", "13")
Sanders14 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=114491", "Sanders", "14")
Sanders15 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=114486", "Sanders", "15")
Sanders16 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=114488", "Sanders", "16")
Sanders17 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=114494", "Sanders", "17")

Sanders_Corpus <- bind_rows(Sanders1,  Sanders2, Sanders3, Sanders4, Sanders5, Sanders6, Sanders7, Sanders8, Sanders9, Sanders10, Sanders11, Sanders12, Sanders13, Sanders14, Sanders15, Sanders16, Sanders17)

get_Trump_speeches <- function(x, y){
  df1 <- read_html(x) %>%
    html_nodes("p") %>%
    html_text()
  
  df2 <- read_html(x)%>%
    html_node(".docdate")%>%
    html_text()
  
  
  speech <- data_frame(text = df1) %>%
    mutate(author = "Trump",
           docnumber = y,
           parnumber = row_number(),
           date = df2) %>%
    separate(date, into = c("day/month", "year"), sep = ",")
  speech <- unnest_tokens(speech, word, text, token = "words")  
  return(speech)
}  

Trump1 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119182", "1")
Trump2 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119181", "2")
Trump3 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119188", "3")
Trump4 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119187", "4")
Trump5 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119186", "5")
Trump6 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119185", "6")
Trump7 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119184", "7")
Trump8 <- get_Trump_speeches('http://www.presidency.ucsb.edu/ws/index.php?pid=119183', "8")
Trump9 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119174", "9")
Trump10 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119172", "10")
Trump11 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119180", "11")
Trump12 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119173", "12")
Trump13 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119170", "13")
Trump14 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119169", "14")
Trump15 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119168", "15")
Trump16 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119167", "16")
Trump17 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119166", "17")
Trump18 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119179", "18")
Trump19 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119202", "19")
Trump20 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119201", "20")
Trump21 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119200", "21")
Trump22 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119203", "22")
Trump23 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119191", "23")
Trump24 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119189", "24")
Trump25 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119192", "25")
Trump26 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119207", "26")
Trump27 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119208", "27")
Trump28 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119209", "28")
Trump29 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119190", "29")
Trump30 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119206", "30")
Trump31 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119206", "31")
Trump32 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119193", "32")
Trump33 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119205", "33")
Trump34 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119178", "34")
Trump35 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119204", "35")
Trump36 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119194", "36")
Trump37 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119195", "37")
Trump38 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119177", "38")
Trump39 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119197", "39")
Trump40 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119199", "40")
Trump41 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119198", "41")
Trump42 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119196", "42")
Trump43 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119176", "43")
Trump44 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119175", "44")
Trump45 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119165", "45")
Trump46 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119503", "46")
Trump47 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117935", "47")
Trump48 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117791", "48")
Trump49 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117815", "49")
Trump50 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117790", "50")
Trump51 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117775", "51")
Trump52 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117813", "52")
Trump53 <- get_Trump_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=116597", "53")

Trump_Corpus <- bind_rows(Trump1, Trump2, Trump3, Trump4, Trump5, Trump6, Trump7, Trump8, Trump9, Trump10, Trump11, Trump12, Trump13, Trump14, Trump15, Trump16, Trump17, Trump18, Trump19, Trump20, Trump21, Trump22, Trump23, Trump24, Trump25, Trump26, Trump27, Trump28, Trump29, Trump30, Trump31, Trump32, Trump33, Trump34, Trump35, Trump36, Trump37, Trump38, Trump39, Trump40, Trump41, Trump42, Trump42, Trump43, Trump44, Trump45, Trump46, Trump47, Trump48, Trump49, Trump50, Trump51, Trump52, Trump53)

Cruz1 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=118041", "Cruz", "1")
Cruz2 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=117232", "Cruz", "2")
Cruz3 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=116598", "Cruz", "3")
Cruz4 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=114768", "Cruz", "4")
Rubio1 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=111441", "Rubio", "5")
Kasich1 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=116599", "Kasich", "6")
Kasich2 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=113069", "Kasich", "7")

Repub_Corpus <- bind_rows(Cruz1, Cruz2, Cruz3, Cruz4, Rubio1, Kasich1, Kasich2)


Total_Corpus <- bind_rows(Clinton_Corpus, Sanders_Corpus, Trump_Corpus, Repub_Corpus)

write_feather(Total_Corpus, "TotalCorpus")
