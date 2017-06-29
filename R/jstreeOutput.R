#' @export
jstreeOutput <- function(outputId, checkbox=FALSE, search=FALSE, search_placeholder = ""){

    searchEl <- shiny::div("")
    if (search == TRUE){
        search <- paste0(outputId, "-search-input")
        searchEl <- shiny::tags$input(id=search, class="form-control", type="text", value="")
    }
    if (is.character(search)){
        # Either the search field we just created or the given text field ID
        searchEl <- shiny::tagAppendChild(searchEl, shiny::tags$script(type="text/javascript", shiny::HTML(
            paste0("jstreeFun.initSearch('",outputId,"','",search,"');"))))
    }

    searchEl <- shiny::tags$div(
        class="form-group shiny-input-container",
        searchEl
    )

    shiny::tagList(
        shiny::singleton(shiny::tags$head(
            initResourcePaths(),
            shiny::tags$link(rel = 'stylesheet', type = 'text/css',
                             href = 'jstree/jsTree-3.3.4/themes/default/style.min.css'),
            shiny::tags$link(rel = 'stylesheet', type = 'text/css',
                             href = 'jstree/jstree.css'),
            shiny::tags$link(rel = "stylesheet", type = "text/css",
                             href = "shared/font-awesome/css/font-awesome.min.css"),
            shiny::tags$script(src = 'jstree/jsTree-3.3.4/jstree.min.js'),
            shiny::tags$script(src = 'jstree/jstree.js')
        )),
        searchEl,
        shiny::div(id=outputId, class = "shiny-jstree",
                   `data-st-checkbox` = checkbox,
                   `data-st-search` = is.character(search))
    )
}