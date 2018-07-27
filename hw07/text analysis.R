library(tidyverse)
library(tidytext)
library(rvest)
library(stringr)


#Function to retrieve documents and clean it up

get_speeches <- function(x, y, z){
  df <- read_html(x) %>%
    html_nodes("p") %>%
    html_text() 
  
  speech <- data_frame(text = df) %>%
    mutate(author = y,
           docnumber = z,
           parnumber = row_number())
  speech <- unnest_tokens(speech, word, text, token = "words")  
  return(speech)
}


#Getting most recent Clinton's Speeches prior to November 8th
Clinton1 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119498", "Clinton", "1")
Clinton2 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119502", "Clinton", "2")
Clinton3 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119501", "Clinton", "3")
Clinton4 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119500", "Clinton", "4")
Clinton5 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119499", "Clinton", "5")
Clinton6 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119497", "Clinton", "6")
Clinton7 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119157", "Clinton", "7")
Clinton8 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119156", "Clinton", "8")
Clinton9 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119155", "Clinton", "9")
Clinton10 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119154", "Clinton", "10")
Clinton_Corpus <- bind_rows(Clinton1, Clinton2, Clinton3, Clinton4, Clinton5, Clinton6, Clinton7, Clinton8, Clinton9, Clinton10)

#Getting most recent Sander's Speeches during his Presidential Run
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
Sanders_Corpus <- bind_rows(Sanders1, Sanders2, Sanders3, Sanders4, Sanders5, Sanders6, Sanders7, Sanders8, Sanders9, Sanders10)


#Getting Trump's most recent speeches prior to Nov 8th

Trump1 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119182", "Trump", "1")
Trump2 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119181", "Trump", "2")
Trump3 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119188", "Trump", "3")
Trump4 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119187", "Trump", "4")
Trump5 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119186", "Trump", "5")
Trump6 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119185", "Trump", "6")
Trump7 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119184", "Trump", "7")
Trump8 <- get_speeches('http://www.presidency.ucsb.edu/ws/index.php?pid=119183', "Trump", "8")
Trump9 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119174", "Trump", "9")
Trump10 <- get_speeches("http://www.presidency.ucsb.edu/ws/index.php?pid=119172", "Trump", "10")
Trump_Corpus <- bind_rows(Trump1, Trump2, Trump3, Trump4, Trump5, Trump6, Trump7, Trump8, Trump9, Trump10)

#Pulling together all three corpi
speech_corpus <- bind_rows(Clinton_Corpus, Sanders_Corpus, Trump_Corpus)
#We now have a fairly decent size data set to work with now

#Inserting Sentiment
speech_corpus_bing <- speech_corpus %>%
  inner_join(get_sentiments("bing"))
#83936 - 10608 = number of words discarded
speech_corpus_affin <- speech_corpus %>%
  inner_join(get_sentiments("afinn"))
#83936 - 11562 = number of words we discarded 
speech_corpus_nrc <- speech_corpus %>%
  inner_join(get_sentiments("nrc"))
#83936 - 43920 = number of words we discarded

speech_corpus_bing %>%
  count(author, sentiment) %>%
  mutate(percent= n/sum(n))%>%
  print()%>%
  ggplot(aes(author, percent, fill= author)) +
  geom_bar(alpha = .75, stat = "identity", width = .5 )+
  facet_grid(~sentiment)+
  labs(x= "Speaker",
       y= "Percentage of Text") +
  coord_flip()

speech_corpus_nrc %>%
  count(author, sentiment) %>%
  mutate(percent = n/sum(n)) %>%
  print()%>%
  ggplot(aes(sentiment, percent, fill= sentiment)) +
  geom_bar(alpha = .8, stat = "identity")+
  facet_wrap(~author) +
  coord_flip()

speech_corpus_nrc %>%
  count(author, sentiment) %>%
  ggplot(aes(sentiment, n)) +
  geom_freqpoly(aes(color= author, group= author), stat = "identity")

speech_corpus_nrc %>%
  count(author, sentiment) %>%
  mutate(percent= n/sum(n)) %>%
  ggplot(aes(sentiment, percent)) +
  geom_freqpoly(aes(color= author, group= author), stat = "identity")


speech_corpus_nrc %>%
  count(sentiment, author) %>%
  group_by(sentiment) %>%
  mutate(percent = n/sum(n)) %>%
  print() %>%
  ggplot(aes(author, percent, fill= author)) +
  geom_bar(stat = "identity", alpha = .85) +
  facet_wrap(~sentiment) +
  coord_flip() +
  labs(x = "sentiment",
       y= "% of Sentiment Between Candidates")


speech_corpus_affin %>%
  group_by(author, docnumber) %>%
  mutate(numeric_sentiment = cumsum(score)) %>%
  mutate(percent = as.integer(docnumber)) %>%
  mutate(percent= cumsum(percent/sum(percent))) %>%
  ggplot(aes(percent, numeric_sentiment, color = docnumber))+
  geom_freqpoly(stat = "identity") +
  facet_wrap(~author)


