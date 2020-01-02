library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(tidyr)
library(knitr)
library(readr)
library(shiny)
library(tidyverse)
library(leaflet)
library(shinydashboard)
library(plotly)
library(maps)
library(highcharter)
library(countrycode)
server <- function(input, output) {
  
  
  ###### Moinak Dataset Import ######################################
  sui_ind<-read.csv('suicides_in_India.csv')
  
  master1<-read.csv('master.csv')
  
  master_2<-master1 
  
  
  master_map<-read.csv('master_map.csv')
  
  master_map <- master_map %>%
    mutate(ï..country = fct_recode(ï..country, "The Bahamas" = "Bahamas"),
            ï..country = fct_recode(ï..country, "Cape Verde" = "Cabo Verde"),
            ï..country = fct_recode(ï..country, "South Korea" = "Republic of Korea"),
            ï..country = fct_recode(ï..country, "Russia" = "Russian Federation"),
            ï..country = fct_recode(ï..country, "Republic of Serbia" = "Serbia"),
            ï..country = fct_recode(ï..country, "United States of America" = "United States"))
  
  country_tibble <- master_map %>% mutate(country=ï..country) %>% 
    select(country, suicides_no, population, year) %>%
    group_by(country) %>%
    summarize(suicide_capita = round((sum(suicides_no)/sum(population))*100000, 2)) 
  #filter(year==input$select_map_moi)
  
  
  ###### Moinak Dataset Import  Closes ######################################
  ###### Moinak has done wrangling by piping ################################
  
  
  ###### Anindita's Data Wrangling Starts here ###################################
  
  mapData<-read.csv("mapData.csv")
  worldmap <- map_data("world")
  names(worldmap)[names(worldmap)=="region"] <- "Country"
  worldmap$Country[worldmap$Country == "USA"] <- "United States"
  
  
  populationData<-read.csv("population_total.csv")
  populationData<-populationData %>% gather(year,value,-Country)
  populationData<-populationData %>% mutate(year=as.numeric(substring(year,2,5)))
  
  DataSet_2015<-read.csv("2015_dataset.csv")
  DataSet_2015$year<-2015
  DataSet_2015<-merge(DataSet_2015,populationData,by=c("Country","year"))
  DataSet_2015<-merge(DataSet_2015,mapData,by=c("Country"))
  
  
  DataSet_2016<-read.csv("2016_dataset.csv")
  DataSet_2016$year<-2016
  DataSet_2016<-merge(DataSet_2016,populationData,by=c("Country","year"))
  DataSet_2016<-merge(DataSet_2016,mapData,by=c("Country"))
  
  DataSet_2017<-read.csv("2017_dataset.csv")
  DataSet_2017$year<-2017
  DataSet_2017<-merge(DataSet_2017,populationData,by=c("Country","year"))
  DataSet_2017<-merge(DataSet_2017,mapData,by=c("Country"))
  
  DataSet_2018<-read.csv("2018_dataset.csv")
  DataSet_2018$year<-2018
  DataSet_2018<-merge(DataSet_2018,populationData,by=c("Country","year"))
  DataSet_2018<-merge(DataSet_2018,mapData,by=c("Country"))
  
  DataSet_2019<-read.csv("2019_dataset.csv")
  DataSet_2019$year<-2019
  DataSet_2019<-merge(DataSet_2019,populationData,by=c("Country","year"))
  DataSet_2019<-merge(DataSet_2019,mapData,by=c("Country"))
  
  newData<-full_join(DataSet_2015,DataSet_2016)
  newData<-full_join(newData,DataSet_2017)
  newData<-full_join(newData,DataSet_2018)
  newData<-full_join(newData,DataSet_2019)
  
  
  happy_world <- newData %>% full_join(worldmap, by = "Country")
  
  
  
  
  map_theme <- theme(
    axis.title.x = element_blank(),
    axis.text.x  = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y  = element_blank(),
    axis.ticks.y = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank() )
  
  ##### Anindita's Data Wranglingling closes here #######################################################
  
  ####### Anindita's code open here ##################################################################
  
  output$mapPlot<-renderPlotly({
    print(ggplotly(
      happy_world %>% filter(year==input$select_ani_map_1) %>% ggplot(mapping = aes(x = long, y = lat, group = group,
                                                                                    text = paste0(
                                                                                      "<b>Population: </b>", value,"<br>",
                                                                                      "<b>Hapiness Rank: </b>", Happiness_Rank,"<br>",
                                                                                      "<b>Country: </b>", Country,"<br>",
                                                                                      "<b>Economy: </b>", Economy,"<br>"))) +
        geom_polygon(aes(fill = `Happiness_Score`))  +
        scale_fill_continuous(low="thistle2", high="darkred", na.value="snow2") +
        coord_quickmap() +
        labs(title = "Happiness Around the World") +
        map_theme+
        theme(legend.position = "bottom",
              panel.background = element_rect(fill = NULL,size=2.2))
    ))
  })
  
  output$boxPlot<-renderPlotly({
    print(ggplotly(newData %>% filter(year==input$select_ani_1) %>% ggplot( aes(x = Continent, y = Happiness_Score)) +
                     geom_boxplot(aes(color = Continent, fill = Continent,
                                      text = paste0(
                                        "<b>Population:", value,"<br>",
                                        "<b>Hapiness Rank:", Happiness_Rank,"<br>",
                                        "<b>Country:", Country,"<br>",
                                        "<b>Economy:", Economy,"<br>")), alpha = 0.5) +
                     geom_point(aes(color = Continent), position = position_jitter(width = .1)) +
                     labs(title = "Average Happiness By Region", 
                          x = "Continent", 
                          y = "Happiness Score") +
                     theme_minimal() +
                     theme(plot.title = element_text(size = rel(2.5)),
                           axis.title = element_text(size = rel(1.5)),
                           axis.text.x = element_blank(),
                           axis.text.y = element_blank())
    ))
  })
  
  
  output$linePlot<-renderPlotly({
    print(ggplotly(
      ggplot(data = newData) +
        geom_line(mapping = aes(x = year, y = Happiness_Score, group = Country, 
                                color = Continent),
                  alpha = 0.5, show.legend = FALSE) +
        geom_point(aes(x = year, y = Happiness_Score, color = Continent,
                       text = paste0(
                         "<b>Hapiness Rank: </b>", Happiness_Rank,"<br>",
                         "<b>Country: </b>", Country,"<br>",
                         "<b>Economy: </b>", Economy,"<br>")), 
                   position = position_jitter(width = .1),
                   alpha = 0.5,
                   show.legend = FALSE) +
        labs(title = "Change in Happiness Scores 2015-19", 
             x = "Year", 
             y = "Happiness_Score") +
        theme_minimal() +
        theme(plot.title = element_text(size = rel(2.0)),
              axis.title = element_text(size = rel(1.0)),
              strip.text.x = element_text(size = rel(1.0))) +
        facet_wrap(~ Continent)
    ))
    
  })
  
  newData1 <- newData[order(as.integer(newData$year),as.integer(newData$Happiness_Rank),decreasing = FALSE), ]
  
  output$factorsPlot<-renderPlotly({
    print(ggplotly(
      newData1 %>%  filter(year==input$select_ani_2) %>% head(10) %>%  
        gather(Factor, `Importance of Factor`, Economy:Generosity, factor_key=TRUE) %>% 
        ggplot() +
        geom_bar(stat = "identity", 
                 aes(x = Country, y = `Importance of Factor`, fill = Factor)) +
        coord_flip() +
        theme_minimal() +
        theme(legend.position = "top") +
        labs(title = "The Six Factors of Happiness in the Ten Happiest Countries") +
        theme(plot.title = element_text(size = rel(1.5)),
              axis.title = element_text(size = rel(1.5)))
    ))
    
  })
  
  
  
  
  
  ####### Anindit's code closes here ######################################################################
  
  
  ####### Moinak's code starts here ######################################################################
  
  
  output$Top10<-renderPlot(
    
    master1 %>% 
      filter(year==input$select6) %>% 
      group_by(ï..country) %>% 
      summarise(sum(suicides_no)) %>% 
      arrange(`sum(suicides_no)`) %>% 
      tail(n=10) %>% 
      ggplot(aes(x= reorder(ï..country , -`sum(suicides_no)`), y=`sum(suicides_no)`))+
      geom_bar(stat="identity", colour='#FF0000', fill='#FF0000')+
      ggtitle("Top 10 countries committing suicides for a particular year")+
      theme(plot.title = element_text(lineheight=1.5, face="bold"))+
      xlab("Country")+ylab("Number of Suicides")
    
  )
  
  
  
  output$plot2<-renderPlotly({
    print(ggplotly(
      
      age_master<-master1 %>% 
        group_by(ï..country, year, age, gdp_per_capita....) %>% 
        summarise(total_suicides=sum(suicides_no)) %>% 
        filter(ï..country==input$select) %>% 
        ggplot(aes(x=year,y=total_suicides,group=age, col=age))+geom_line(lwd=0.7)+geom_point(size=0.7)+
        ggtitle("Yearwise Age Groups commiting suicides")+
        ylab("Total suicidie by Country ")+
        theme(plot.title = element_text(lineheight=1.5, face="bold"))
      , 
      originalData = FALSE
      
    ))
  })
  
  
  output$genderplot<-renderPlot(
    
    master1 %>% 
      filter(ï..country==input$select2) %>% 
      group_by(sex) %>% 
      summarise(sum(suicides_no)) %>% 
      ggplot(aes(x=sex, y=`sum(suicides_no)`, colour=sex, fill=sex))+geom_bar(stat = "identity")+
      ggtitle("Countrywise Gender vs Suicides")+
      theme(plot.title = element_text(lineheight=1.5, face="bold"))+
      ylab("Total Suicides")
  )
  
  
  
  output$mapPlot_moi <- renderHighchart({
    
    
    highchart() %>%
      hc_add_series_map(worldgeojson, country_tibble, value = "suicide_capita", joinBy = c('name','country'))  %>% 
      hc_colorAxis(stops = color_stops()) %>% 
      hc_title(text = "Suicides by Country") %>% 
      hc_subtitle(text = "1985-2015") %>%
      hc_tooltip(borderWidth = 1.5, headerFormat = "", valueSuffix = " suicides (per 100K people)")
    
  })
  
  
  ####### Moinak's Code closes here ########################################################################
  
  
  
}