# Supporting functions
create_image_div <- function(id, url, img_size) {
  shiny::div(style = "display:inline-block;margin:5px;",
    tags$img(src = url, width = img_size, height = img_size),
    shiny::p(id),
    actionButton(paste0("button",id), "+", style = "margin:1px;")
  )
}

# Main addin function
nounAddin <- function() {
  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Noun Project Icons Search"),
    miniUI::miniContentPanel(
      shiny::div(style = "display:inline-block",
          shiny::textInput("search", "What icon do you want to find?")),
      shiny::div(style = "display:inline-block",
          shiny::actionButton("searchButton", "Search")),
      shiny::div(shiny::uiOutput("images"), id = "imagesFrame"),
      shiny::div(shiny::p("Selected icons:"),
          shiny::verbatimTextOutput("selection", placeholder = TRUE),
          shiny::actionButton("clear", "Clear selection"))
    )
  )
  
  server <- function(input, output, session) {
    img_size = "60px"
    obs_list <- list()
    icons_selection <- c()

    shiny::observeEvent(input$done, {
      rstudioapi::sendToConsole(paste(icons_selection, collapse=","),
                                execute = F)
      shiny::stopApp()
    })
    shiny::observeEvent(input$cancel, {
      shiny::stopApp(NULL)
    })

    shiny::observeEvent(input$searchButton, {
      imlist <- tryCatch({
        get_icon_by_term(input$search, 20)
      }, error = function(e) {
        NULL
      })
      
      imurls <- get_icons_urls(imlist)

      output$images <- shiny::renderUI({
        shiny::validate(
          need(!is.null(imlist), message = paste0("Permission error!\nSet your credentials ",
                                                 "using np_credentials() function\n")
          )
        )
        shiny::validate(
          need(length(imurls) != 0, message = paste0("A problem with search occured!\n",
                                                     "Try searching for a different term.\n")
               )
        )
        
        lapply(imurls,
               function(x) {
                 btn_name <- paste0("button", x$id)
                 obs_list[[btn_name]] <<- observeEvent(input[[btn_name]], {
                   icons_selection <<- c(icons_selection, x$id)
                   output$selection <- renderText({ icons_selection })
                   shiny::showNotification(paste(x$id, "selected"), duration=2)
                 })
                 create_image_div(x$id, x$url, img_size)
                }
        )
      })
    })
    shiny::observeEvent(input$clear, {
      icons_selection <<- c()
      output$selection <- shiny::renderText({ "" })
    })
  }
  viewer <- shiny::paneViewer(300)
  shiny::runGadget(ui, server, viewer = viewer)
}
