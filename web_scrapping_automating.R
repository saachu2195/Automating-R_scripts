## Web Scrapping and Automating the task ##
setwd("C:/Users/square/Desktop/R_Project")

library(rvest)

web_page <- read_html("https://www.reddit.com/r/politics/comments/dpnjut/house_democrats_are_just_trying_to_invalidate_the/")

## Title of Pages
web_page %>%
  html_node('title') %>%
  html_text()

## Comments of Pages
web_page %>%
  html_nodes('p._1qeIAgB0cPwnLhDF9XSiJM') %>%
  html_text()

web_page_news = read_html("https://www.reddit.com/r/politics/new/")

## Time 
time <- web_page_news %>%
  html_nodes('a._3jOxDPIQ0KaOWpzvSQo-1s') %>%
  html_text()

time

## Urlsx
urls <- web_page_news %>%
  html_nodes('a._3jOxDPIQ0KaOWpzvSQo-1s') %>%
  html_attr('href')

urls
  
## Putting into dataframe
web_page_times <- data.frame(Urls = urls, Time = time)
head(web_page_times)

## Chacking the dimension
dim(web_page_times)

titles = c()
comments = c()

for (i in web_page_times$Urls){
  web_page_recent = read_html(i)
  title <- web_page_recent %>%
    html_node('title') %>%
    html_text()
  titles <- append(titles, rep(title, each = length(body)))
  
  web_page_recent = read_html(i)
  body <- web_page_recent %>%
    html_nodes('p._1qeIAgB0cPwnLhDF9XSiJM') %>%
    html_text()
  comments <- append(comments, body)
}

web_hourly_data <- data.frame(titles, comments)
dim(web_hourly_data)
tail(web_hourly_data)

## Removing
disclaimers <- c("Virginia Elections Feature Competitive Races Where There Have Been None for Years : politics")

new_webpage <- subset(web_hourly_data, !(titles %in% c(disclaimers)))

dim(new_webpage)

## Sentment
library(sentimentr)

## Convert the comments from factor to character
new_webpage$comments <- as.character(new_webpage$comments)

score <- sentiment(new_webpage$comments)
score_average <- sum(score$sentiment)/length(score$sentiment)
score_average

## Sending Emails.
library(sendmailR)
from <- "<saachu20@gmail.com>"
to <- "<saachu20@gmail.com>"

