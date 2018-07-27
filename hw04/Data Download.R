#Downloading the Data Set
library(downloader)

download(url = "http://football-data.co.uk/mmz4281/1314/D1.csv", destfile = "Germansoccer.csv")
#Downloaded 2013/2014 Bundesliga Match Day Stats
Bundesliga <- read.csv("Germansoccer.csv")
Bundesliga <- as_tibble(Bundesliga)
Bundesliga <- select(Bundesliga,`Div`:`AR`)
#The rest of the data set are odds for different gambling services
#This data set seems incomplete from the variables that are promised in the ReadMe

