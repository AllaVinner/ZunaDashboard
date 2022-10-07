library('dplyr')
library('plotly')
library('tibble')
library(ggplot2)  
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
