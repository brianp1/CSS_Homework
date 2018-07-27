library(shiny)
library(tidyverse)
library(tidytext)
library(rvest)
library(feather)
library(stringr)

ui <- fluidPage(titlePanel("Word Analysis of 2016 Presidental Campaign Speeches"),
                sidebarLayout(
                  sidebarPanel(
                    selectInput(
                      "authorInput",
                      "Speaker",
                      choices = c("Clinton", "Cruz/Kasich/Rubio", "Sanders", "Trump"),
                      multiple = TRUE,
                      selected = c("Clinton", "Cruz/Kasich/Rubio", "Sanders", "Trump")
                    ),
                    sliderInput(
                      "sentInput",
                      "Sentiment Value",
                      min = -5,
                      max = 5,
                      value = c(0, 5)
                    ),
                    selectInput(
                      "monthInput",
                      "Month",
                      choices = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"),
                      selected = c("September", "October", "November", "December"),
                      multiple = TRUE
                    ),
                    selectInput(
                      "yearInput",
                      "Year",
                      choices = c("2015", "2016"),
                      selected = c("2015", "2016"),
                      multiple = TRUE
                    ),
                    uiOutput("wordInput")
                  ),
                  mainPanel(plotOutput("Frequency"),
                            tableOutput("Count"), 
                            tableOutput("Words"))
                ))


