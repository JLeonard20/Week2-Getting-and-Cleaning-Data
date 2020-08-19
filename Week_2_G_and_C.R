# Getting and Cleaning Data Week 2 Quiz.
# Week 2 Quiz solutions.

install.packages("httpuv")
library(httpuv)
install.packages("httr")
library(httr)

# find OAuth settings for github.
oauth_endpoints("github")

# register an application

myapp <- oauth_app("github", key = "95cd4d3dc573a38dc87a",
                   secret = "d70304e7d385af083bde8bc30d8ca802e709708b")

# get OAuth credentials

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# use API

req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
output <- content(req)

# find datasharing

datashare <- which(sapply(output, FUN=function(X) "datasharing" %in% X))

datashare

class(output)
names(output)
output[[19]]

list(output[[19]]$name, output[[19]]$created_at)

# Question 2

install.packages("sqldf")
library(sqldf)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

getwd()
setwd("./data")

download.file(fileUrl, destfile = "acs.csv")

# load the data into dataframe

acs <- read.csv("acs.csv")
head(acs)

# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

sqldf("select pwgtp1 from acs where AGEP < 50")


# Question 3
# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

sqldf("select distinct AGEP from acs")


# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:

install.packages("html")
library(html)

htmlUrl <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(htmlUrl)
close(htmlUrl)

head(htmlCode)

c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

# Question 5

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

SST <- read.fwf(fileUrl2, skip = 4, widths = c(12,7,4,9,4,9,4,9,4))

sum(SST[, 4])



