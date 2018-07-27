read_feather("TotalCorpus")


Corpus_Sent <- Total_Corpus %>%
  inner_join(get_sentiments("nrc"))

Corpus_Sent <- Corpus_Sent %>%
  group_by(author, docnumber) %>%
  count(sentiment)
Corpus_Sent


sentiment_forest <- Corpus_Sent %>%
  select(author, sentiment, n, docnumber) %>%
  mutate(docid = paste0(author, docnumber))
sentiment_forest

sentiment_dtm <- cast_dtm(sentiment_forest, term = sentiment, value = n, document = docid)
sentiment_dtm

author_doc_2 <- sentiment_forest %>%
  select(author, docnumber) %>%
  unique()
author_doc2

as_forest <- train(y = author_doc_2$author, x = as.matrix(sentiment_dtm),
                   method = "rf",
                   ntree = 200,
                   trControl = trainControl(method = "oob"))
as_forest

str(as_forest, max.level = 1)
as_forest$finalModel

kable(as_forest$finalModel$confusion)

getTree(as_forest$finalModel, labelVar = TRUE)

varImpPlot(as_forest$finalModel)
