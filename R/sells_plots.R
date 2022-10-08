library('dplyr')
library('plotly')
library('tibble')
library(ggplot2) 
library('purrr')
source('R/salesGenerator.R')

sell_story <- function(sell_tbl, product) {
  gg <- ggplot(sell_tbl, aes(x = .data[[product]], color = 'density')) + 
    geom_density(color = '#67B7D1') +  
    geom_rug(color = '#67B7D1') + 
    ylab("Sells per year") + 
    xlab("")  + theme(legend.title=element_blank()) +
    scale_color_manual(values = c('density' = '#67B7D1'))
  
  ggplotly(gg)%>% 
    layout(plot_bgcolor='#e5ecf6',
           xaxis = list(   
             title='Time', 
             zerolinecolor = '#ffff', 
             zerolinewidth = 2,   
             gridcolor = 'ffff'),
           yaxis = list(   
             title='# Sells per year',
             zerolinecolor = '#ffff', 
             zerolinewidth = 2,   
             gridcolor = 'ffff')) 
}


sell_story_single <- function(fig, column_name) {
  fig +
    geom_density(
        mapping = aes(x = .data[[column_name]], color = 'density'), 
        color = '#67B7D1'
    ) +  
    geom_rug() + 
    ylab("") + 
    xlab("")  + 
    scale_color_manual(values = c('density' = '#67B7D1'))
}


sell_story2 <- function(sell_tbl) {
  gg <- ggplot(sell_tbl) + 
    geom_density(
      mapping = aes(x = sold, color = name)
    ) +  
    geom_rug(
      mapping = aes(x = sold, color = name)
    ) + 
    ylab("") + 
    xlab("")

  ggplotly(gg)%>% 
    layout(plot_bgcolor='#e5ecf6',
           xaxis = list(   
             title='Time', 
             zerolinecolor = '#ffff', 
             zerolinewidth = 2,   
             gridcolor = 'ffff'),
           yaxis = list(   
             title='# Sells per year',
             zerolinecolor = '#ffff', 
             zerolinewidth = 2,   
             gridcolor = 'ffff')) 
}


