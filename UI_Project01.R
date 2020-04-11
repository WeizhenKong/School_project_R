#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(tidyverse)
library(leaflet)
library(ECharts2Shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    br(),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            fileInput("csvInput", label = "Choose csv file",
                      accept = c("text/csv","text/comma-separated-values","text/plain",".csv")),
            hr(),
            sliderInput("freq",
                        "Minimum Frequency for word cloud:",
                        min = 1,  max = 50, value = 1),
            sliderInput("max",
                        "Maximum Number of Words for word cloud:",
                        min = 1,  max = 300,  value = 100),
            selectInput("country",label = "Show ranking in countries",
                        choices = c("Australia" = "AU", "Belgium" = "BE","Bermuda" = "BM","Canada" = "CA","China" = "CN","Finland" = "FI","France" = "FR","Germany" = "DE","Italy" = "IT","Japan" = "JP","Netherlands" = "NL","Russia" = "RU","South Korea" = "KR","Spain" = "ES","Switzerland" = "CH","United Kingdom" = "UK","United States" = "US"),selected = "US"),
            selectInput("category",label = "Show ranking in categories:",
                        choices = c('Banking' = 'Banking', 'Chemicals' = 'Chemicals', 'Conglomerates' = 'Conglomerates', 'Consumer durables'='Consumer durables', 'Diversified financials'='Diversified financials', 'Drugs & biotechnology'='Drugs & biotechnology', 'Food drink & tobacco'='Food drink & tobacco', 'Food markets'='Food markets', 'Household & personal products'='Household & personal products', 'Insurance'='Insurance', 'Media'='Media', 'Oil & gas operations'='Oil & gas operations', 'Retailing'='Retailing', 'Semiconductors'='Semiconductors', 'Software & services'='Software & services', 'Technology hardware & equipment'='Technology hardware & equipment', 'Telecommunications services'='Telecommunications services', 'Transportation Utilities'='Transportation Utilities'),selected = "Banking")
        ),

        # Show a plot of the generated distribution
        mainPanel(navbarPage("The Forbes 2000 Ranking of the World's Biggest Companies (Year 2004)",
                             tabPanel("Description", textOutput("description"), hr(),
                                      img(src='forbes_global2.png', align = "center")),
                             
                             navbarMenu("Plots",tabPanel("plot",plotOutput("distPlot")),
                                        tabPanel("interactive",plotOutput("interactive"))
                                 
                             ),
                tabPanel("Data Table",tableOutput("datatable")),
                tabPanel("Word cloud",plotOutput("plot"))
            ))
        )
    )
)
