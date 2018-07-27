read_feather("forestdataframe")

corpus_split <- resample_partition(forestdataframe,
                                   c(test = 0.1, train = 0.9))

  