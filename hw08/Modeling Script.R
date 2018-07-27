
read_feather("TotalCorpus")

corpus_forest <- Total_Corpus %>%
  group_by(author, docnumber) %>%
  count(word) %>%
  select(author, word, n, docnumber) %>%
  mutate(docid = paste0(author, docnumber))
corpus_forest

speech_dtm <- cast_dtm(corpus_forest, term = word, value = n, document = docid)

author_doc <- corpus_forest %>%
  select(author, docnumber) %>%
  unique()
author_doc

aw_forest <- train(y = author_doc$author, x = as.matrix(speech_dtm),
                   method = "rf",
                   ntree = 200,
                   trControl = trainControl(method = "oob"))

aw_forest

str(aw_forest, max.level = 1)
aw_forest$finalModel

kable(aw_forest$finalModel$confusion)

getTree(aw_forest$finalModel, labelVar = TRUE)

varImpPlot(aw_forest$finalModel)


write_feather(corpus_forest, "forestdataframe")






