
## Loading the necessary packages
rm(list = ls())
library(quanteda) 
library(wordcloud)
library(RColorBrewer)

## Getting the data
#folder <- "./Coursera-SwiftKey/final/en_US/"

#blogs_file <- paste(folder, "en_US.blogs.txt", sep = "")
#twitter_file <- paste(folder, "en_US.twitter.txt", sep = "")
#news_file <- paste(folder, "en_US.news.txt", sep = "")

#rm(folder)

#if (!file.exists(blogs_file) |
#    !file.exists(twitter_file) |
#    !file.exists(news_file)) {
#  zipfile <- "./Coursera-SwiftKey.zip"
#  if (!file.exists(zipfile)) {
#    url <- download.file("http://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip",destfile = zipfile, mode = "wb")
#  }
#  unzip(zipfile, exdir = "./Coursera-SwiftKey")
#  rm(zipfile)
#}

bfile <- file(blogs_file, open = "rb")
blogs <- readLines(bfile, encoding= "UTF-8", warn = FALSE, skipNul = TRUE)
close(bfile)
rm(bfile, blogs_file)

tfile <- file(twitter_file, open = "rb")
twitter <- readLines(tfile, encoding= "UTF-8", warn = FALSE, skipNul = TRUE)
close(tfile)
rm(tfile, twitter_file)

nfile <- file(news_file, open = "rb")
news <- readLines(nfile, encoding= "UTF-8", warn = FALSE, skipNul = TRUE)
close(nfile)
rm(nfile, news_file)

blogs <- iconv(blogs, from = "UTF-8", to = "ASCII", sub = "")
twitter <- iconv(twitter, from = "UTF-8", to = "ASCII", sub = "")
news <- iconv(news, from = "UTF-8", to = "ASCII", sub = "")

## Data sampling
set.seed(1)
data.sample <- c(sample(blogs, length(blogs) * 0.05, replace = FALSE),
                 sample(news, length(news) * 0.05, replace = FALSE),
                 sample(twitter, length(twitter) * 0.05, replace = FALSE))
if (!file.exists("data.sample.Rdata")) {
  save("data.sample",file="data.sample.Rdata")
  rm(blogs)
  rm(news)
  rm(twitter)
} else {
  load("data.sample.Rdata")
}

## Tokenizing
df1 <- dfm(data.sample, verbose = TRUE, tolower = TRUE,
           remove_numbers = TRUE, remove_punct = TRUE, remove_separators =               TRUE, remove_twitter = TRUE, stem = TRUE, remove = 
             stopwords("english"),
           language = "english", thesaurus = NULL,
           dictionary = NULL, valuetype = c("glob", "regex", "fixed"))

df2 <- dfm(data.sample, ngrams=2, concatenator = " ",
           what = "fastestword", 
           verbose = FALSE, tolower = TRUE,
           remove_numbers = TRUE, remove_punct = TRUE, remove_separators = 
             TRUE, remove_twitter = FALSE,
           stem = FALSE, remove = stopwords("english"),
           language = "english", thesaurus = NULL, 
           dictionary = NULL, valuetype = "fixed")

df3 <- dfm(data.sample, ngrams=3, concatenator = " ",
           what = "fastestword",
           verbose = FALSE, tolower = TRUE,
           remove_numbers = TRUE, remove_punct = TRUE, remove_separators = 
             TRUE,
           remove_twitter = FALSE, stem = FALSE, remove = 
             stopwords("english"),
           language = "english", thesaurus = NULL, 
           dictionary = NULL, valuetype = "fixed")

## Prediction algorythm
library(ANLP)
testString <- "i am the one who"
df3 <- list(df3)
predict_Backoff(testString, df3)



## Still missing

# Prediction algorythm that is accuarte and efficient

# Solving no-vocobalury issue

# Removing bad words --> easy
# Shiny App (next word + wordcloud) --> easy
# Presentation (well designed 5 sildes) --> easy

