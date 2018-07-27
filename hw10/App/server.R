library(shiny)
library(tidyverse)
library(tidytext)
library(rvest)
library(feather)
library(stringr)
library(rsconnect)

total_tokens <- read_feather("total_tokens.feather")

server <- function(input, output) {
  
  output$wordInput <- renderUI({
    selectizeInput(
      "wordInput",
      "Word",
      choices = total_tokens$word,
      multiple = TRUE
    )
  })
  
  output$Frequency <- renderPlot({
    tokens <- total_tokens %>%
      count(author, score, month, year, word) %>%
      group_by(author) %>%
      mutate(percent = n / sum(n)) %>%
      ungroup %>%
      filter(
        author %in% input$authorInput,
        score >= input$sentInput[1],
        score <= input$sentInput[2],
        month %in% input$monthInput,
        year %in% input$yearInput)
    
    if(!is.null(input$wordInput)){
      tokens <- filter(tokens, word %in% input$wordInput)
    }
    
    ggplot(tokens, aes(author, percent, fill = author)) +
      geom_bar(stat = "identity", alpha = .8)
  })
  
  
  output$Count <- renderTable({
    tokens1 <- total_tokens %>%
      filter(
        author %in% input$authorInput,
        score >= input$sentInput[1],
        score <= input$sentInput[2],
        month %in% input$monthInput,
        year %in% input$yearInput)
    
    if(!is.null(input$wordInput)){
      tokens1 <- filter(tokens, word %in% input$wordInput)
    }
    
    tokens1 %>%
      count(author)
  })
  
  output$Words <- renderTable({
    tokens2 <- total_tokens %>%
      filter(
        author %in% input$authorInput,
        score >= input$sentInput[1],
        score <= input$sentInput[2],
        month %in% input$monthInput,
        year %in% input$yearInput)
    
    if(!is.null(input$wordInput)){
      tokens2 <- filter(tokens, word %in% input$wordInput)
    }
    tokens2 %>%
      count(author, word)
  })
}  


# deployApp(appDir = "App", appName = "Speeches")


