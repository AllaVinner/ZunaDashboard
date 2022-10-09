library(shiny)
library(shinydashboard)
source('R/salesGenerator.R')
source('R/sells_plots.R')



product_ui <- function(id) {
  tagList(
    tableOutput(NS(id, 'table')),
    plotlyOutput(NS(id, 'plot'))
  )
} 

ui <- dashboardPage(
  dashboardHeader(title = 'Sells Detective'),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Product Story", tabName = "product", icon = icon("arrow-trend-up", verify_fa = FALSE),
               selected = TRUE)
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = 'product', product_ui('product'))
    )
  )
)

product_server <- function(id, db) {
  moduleServer(id, function(input, output, session) {
    message('In product server')
    output$table <- renderTable(head(db$products) %>% discard(~typeof(.x) == 'list'))
    output$plot <- renderPlotly(sell_story2(db$sells))
    
  })
}

server <- function(input, output) {
  sells <- list(
    shirts = generate_beta_sells(100, as.Date('2022-01-01'), as.Date('2022-06-30'), 2, 5),
    pants = generate_beta_sells(70, as.Date('2022-01-01'), as.Date('2022-06-30'), 3, 4) 
  )
  
  
  products <- tibble(
    name = c('Shirt', 'Pants'),
    type = c('Shirt', 'Pants'),
    price = c(590, 750)
  )
  sells = bind_rows(
    tibble(name = 'Shirt', sold = sells$shirts),
    tibble(name = 'Pants', sold = sells$pants)
  )
  
  db <- list(
    products = products,
    sells = sells
  )
  
  db$products <- merge(db$products, db$sells %>% group_by(name) %>% summarize(num_sells = n()))
  
  product_server('product', db)
}



#f <- sell_story(products, 'shirt')

shinyApp(ui, server)


