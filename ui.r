library(shiny)
library(shinydashboard)
library(plotly)
library(maps)
library(highcharter)
library(countrycode)
ui <- dashboardPage(
  dashboardHeader(title=span("Dashboard for Suicides & Happiness"), titleWidth = "400px"),
  dashboardSidebar(
    sidebarMenu(
      
      menuItem(h3("Home"), tabName="home", icon = (icon("fas fa-home","fa-2x"))), 
      
      menuItem(h3("Suicides", tabName = "Suicides"),  icon = (icon("fas fa-sad-tear", "fa-2x")),
               menuSubItem("Top Suicidial Countries", tabName = "Top", icon=icon("bar-chart-o")),
               menuSubItem("Age Group Suicides", tabName = "Age_grp", icon = icon("line-chart")),
               menuSubItem("Gender Group Suicides", tabName = "Gender_Grp", icon = icon("bar-chart-o"))), 
      menuItem(h3("Happiness", tabName = "Happiness"), icon = (icon("far fa-smile", "fa-2x")), 
               menuSubItem("Average Happiness By Region", tabName = "H_world_reg", icon = icon("bar-chart-o")), 
               menuSubItem("Happiness Scores Over Time", tabName = "Happy_Score", icon = icon("line-chart")), 
               menuSubItem("Significant Factors Of Happiness", tabName = "Imp_Factor", icon = icon("bar-chart-o")))
      
    ),
    width = "240"
  ),
  
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "home",
              fluidRow(
                fluidRow(
                  column(12,
                         
                         div(p(h4(strong("Global Data Analysis Of Suicide and Happiness Report",
                                         align = "center"))),style = "color:black")
                  )),
                fluidRow(
                  
                  column(6,
                         
                         div(p(em(" There is but one true philosophical problem and that is suicide."
                         )),style = "color:blue"),
                         p(em("—Albert Camus")), 
              
                           p(" As suicides are too common phenomenon in world today, I have chosen suicidal incidents as my visualization 
                       project and showing three important graphs related to that"), 
                           p(" 1.) The First suicidial graph is about the top ten countries for a particular year who have their 
                       maximum number of suicides"), 
                           p(" 2.) The second one is about the country specific year wise line plot where we could find which age group commit
                       suicides more"), 
                           p(" 3.) The third one is more about total suicidal difference between gender for a particular country")
                         
                  ), 
                  
                  column(6, 
                         div(p(em("To be happy, we must not be too concerned with others."
                         )),style = "color:blue"), 
                         p(em("—Albert Camus")), 
                         div(
                           p("This is an analysis of the World Happiness Report from 2015-2019, looking at worldwide and continent-wise trends in happiness score as well as patterns in the importance of the six factors of happiness in determining overall happiness in each country."), 
                           p("1.) It shows average happiness of each world region for 2015-2019 with a boxplot."), 
                           p("2.) This graph represents how happiness scores changed for each country over time."), 
                           p("3.) It is a closer look at the top 10 happiest countries and how much each of the six factors contributed toward their overall happiness scores. For this, a stacked bar plot would be a useful visualization.")
                           
                         )
                         
                  )
                )), 
              
              fluidRow(
                column(6, p("Plotting the world suicidal data over the world map for year from 1985 to 2015 based on the available 
                            dataset found from the datasource")), 
                column(6, selectInput("select_ani_map_1", "select Year", 
                                      c(2015,
                                        2016,
                                        2017, 
                                        2018,
                                        2019)))
              ), 
              
              fluidRow(
                column(6, highchartOutput("mapPlot_moi")
                       
                       
                ), 
                column(6, plotlyOutput("mapPlot"),
                       p("To know more about World Happiness Report - ",a("https://worldhappiness.report/")))
              )
              
              
              
      ), 
      
      
      tabItem(tabName = "Top",
              fluidRow(column(3,selectInput("select6","Select Year",
                                            c(
                                              1987,
                                              1988,
                                              1989,
                                              1992,
                                              1993,
                                              1994,
                                              1995,
                                              1996,
                                              1997,
                                              1998,
                                              1999,
                                              2000,
                                              2001,
                                              2002,
                                              2003,
                                              2004,
                                              2005,
                                              2006,
                                              2007,
                                              2008,
                                              2009,
                                              2010
                                            ))  )
                       
              ),
              
              fluidRow(column(12,plotOutput(outputId="Top10")))
      ), 
      
      tabItem(tabName = "Age_grp", 
              fluidRow(column(3, selectInput("select", "select country", 
                                             c(
                                               'United States',
                                               'Albania',
                                               'Antigua and Barbuda',
                                               'Argentina',
                                               'Armenia',
                                               'Aruba',
                                               'Australia',
                                               'Austria',
                                               'Azerbaijan',
                                               'Bahamas',
                                               'Bahrain',
                                               'Barbados',
                                               'Belarus',
                                               'Belgium',
                                               'Belize',
                                               'Bosnia and Herzegovina',
                                               'Brazil',
                                               'Bulgaria',
                                               'Cabo Verde',
                                               'Canada',
                                               'Chile',
                                               'Colombia',
                                               'Costa Rica',
                                               'Croatia',
                                               'Cuba',
                                               'Cyprus',
                                               'Czech Republic',
                                               'Denmark',
                                               'Dominica',
                                               'Ecuador',
                                               'El Salvador',
                                               'Estonia',
                                               'Fiji',
                                               'Finland',
                                               'France',
                                               'Georgia',
                                               'Germany',
                                               'Greece',
                                               'Grenada',
                                               'Guatemala',
                                               'Guyana',
                                               'Hungary',
                                               'Iceland',
                                               'Ireland',
                                               'Israel',
                                               'Italy',
                                               'Jamaica',
                                               'Japan',
                                               'Kazakhstan',
                                               'Kiribati',
                                               'Kuwait',
                                               'Kyrgyzstan',
                                               'Latvia',
                                               'Lithuania',
                                               'Luxembourg',
                                               'Macau',
                                               'Maldives',
                                               'Malta',
                                               'Mauritius',
                                               'Mexico',
                                               'Mongolia',
                                               'Montenegro',
                                               'Netherlands',
                                               'New Zealand',
                                               'Nicaragua',
                                               'Norway',
                                               'Oman',
                                               'Panama',
                                               'Paraguay',
                                               'Philippines',
                                               'Poland',
                                               'Portugal',
                                               'Puerto Rico',
                                               'Qatar',
                                               'Republic of Korea',
                                               'Romania',
                                               'Russian Federation',
                                               'Saint Kitts and Nevis',
                                               'Saint Lucia',
                                               'Saint Vincent and Grenadines',
                                               'San Marino',
                                               'Serbia',
                                               'Seychelles',
                                               'Singapore',
                                               'Slovakia',
                                               'Slovenia',
                                               'South Africa',
                                               'Spain',
                                               'Sri Lanka',
                                               'Suriname',
                                               'Sweden',
                                               'Switzerland',
                                               'Thailand',
                                               'Trinidad and Tobago',
                                               'Turkey',
                                               'Turkmenistan',
                                               'Ukraine',
                                               'United Arab Emirates',
                                               'United Kingdom',
                                               # 'United States',
                                               'Uruguay',
                                               'Uzbekistan'
                                             )
                                             
              ))), 
              
              fluidRow(column(12,plotlyOutput(outputId="plot2")))
              
              
              
      ), 
      
      
      tabItem(tabName = "Gender_Grp", 
              fluidRow(column(3, selectInput("select2", "select country", 
                                             c(
                                               
                                               'Albania',
                                               'Antigua and Barbuda',
                                               'Argentina',
                                               'Armenia',
                                               'Aruba',
                                               'Australia',
                                               'Austria',
                                               'Azerbaijan',
                                               'Bahamas',
                                               'Bahrain',
                                               'Barbados',
                                               'Belarus',
                                               'Belgium',
                                               'Belize',
                                               'Bosnia and Herzegovina',
                                               'Brazil',
                                               'Bulgaria',
                                               'Cabo Verde',
                                               'Canada',
                                               'Chile',
                                               'Colombia',
                                               'Costa Rica',
                                               'Croatia',
                                               'Cuba',
                                               'Cyprus',
                                               'Czech Republic',
                                               'Denmark',
                                               'Dominica',
                                               'Ecuador',
                                               'El Salvador',
                                               'Estonia',
                                               'Fiji',
                                               'Finland',
                                               'France',
                                               'Georgia',
                                               'Germany',
                                               'Greece',
                                               'Grenada',
                                               'Guatemala',
                                               'Guyana',
                                               'Hungary',
                                               'Iceland',
                                               'Ireland',
                                               'Israel',
                                               'Italy',
                                               'Jamaica',
                                               'Japan',
                                               'Kazakhstan',
                                               'Kiribati',
                                               'Kuwait',
                                               'Kyrgyzstan',
                                               'Latvia',
                                               'Lithuania',
                                               'Luxembourg',
                                               'Macau',
                                               'Maldives',
                                               'Malta',
                                               'Mauritius',
                                               'Mexico',
                                               'Mongolia',
                                               'Montenegro',
                                               'Netherlands',
                                               'New Zealand',
                                               'Nicaragua',
                                               'Norway',
                                               'Oman',
                                               'Panama',
                                               'Paraguay',
                                               'Philippines',
                                               'Poland',
                                               'Portugal',
                                               'Puerto Rico',
                                               'Qatar',
                                               'Republic of Korea',
                                               'Romania',
                                               'Russian Federation',
                                               'Saint Kitts and Nevis',
                                               'Saint Lucia',
                                               'Saint Vincent and Grenadines',
                                               'San Marino',
                                               'Serbia',
                                               'Seychelles',
                                               'Singapore',
                                               'Slovakia',
                                               'Slovenia',
                                               'South Africa',
                                               'Spain',
                                               'Sri Lanka',
                                               'Suriname',
                                               'Sweden',
                                               'Switzerland',
                                               'Thailand',
                                               'Trinidad and Tobago',
                                               'Turkey',
                                               'Turkmenistan',
                                               'Ukraine',
                                               'United Arab Emirates',
                                               'United Kingdom',
                                               'United States',
                                               'Uruguay',
                                               'Uzbekistan'
                                             )
                                             
              ))), 
              
              fluidRow(column(12,plotOutput(outputId="genderplot")))
              
              
              
      ), 
      
      tabItem(tabName = "H_world_reg", 
              fluidRow(column(3, selectInput("select_ani_1", "Select Year", 
                                             c(2015,
                                               2016,
                                               2017, 
                                               2018,
                                               2019))
              )),
              
              fluidRow(column(12,plotlyOutput(outputId="boxPlot"))),
              fluidRow( column(12, 
                               span(h5(
                                 "Just from these boxplots, we can tell that the average happiness scores across world regions don't change very much from 2015-2019."
                               ))))
              
      ), 
      
      
      tabItem(tabName = "Happy_Score", 
              
              
              fluidRow(column(12,plotlyOutput(outputId="linePlot"))),
              fluidRow( column(12, 
                               span(h5(
                                 "For the most part, the scores for each country do not change significantly from 2015-2019. There are very few countries whose scores decreased significantly, and fewer still whose scores increased significantly. The countries that underwent significant change, if any, were primarily in Sub-Saharan Africa or Latin America & the Caribbean. This makes sense, since countries in these regions are more subject to sudden changes in economy and political stability."
                               ))))
              
              
      ), 
      
      
      tabItem(tabName = "Imp_Factor", 
              fluidRow(column(3, selectInput("select_ani_2", "select Year", 
                                             c(2015,
                                               2016,
                                               2017, 
                                               2018,
                                               2019))
              )), 
              
              fluidRow(column(12,plotlyOutput(outputId="factorsPlot"))),
              fluidRow( column(12, 
                               span(h5(
                                 "In general, Economy and Family seem to the two most important factors of happiness in these countries. Trust (absence of corruption) and Generosity are the least important.
                          There is a new top ranking country, Finland, but the top ten positions are held by the same countries as in the last two years, although with some swapping of places. Four different countries have held top spot in the four most recent reports- Denmark, Switzerland, Norway and now Finland.")
                               )))
              
              
      )
      
      
      
      
      
      
    )
  )
)
