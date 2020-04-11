#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shiny)
library(ggplot2)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Melvin's field goal attempts"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            fileInput("csvInput", label = "Choose csv file",
                      accept = c("text/csv","text/comma-separated-values","text/plain",".csv")),
            selectInput("mop",label = "Show attempts in match or practice:",
                        choices = c("3" = "1", "4" = "2"),selected = "M"),
            selectInput("yon",label = "Show attempts where goal scored(Y) or no goal scored(N):",
                        choices = c("Y" = "Y", "N" = "N"),selected = "Y")),
        #The side bar code end here
        
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
            tabPanel("Data Table",tableOutput("datatable")),
            tabPanel("plot",plotOutput("distPlot"))
        ))
    )
))
