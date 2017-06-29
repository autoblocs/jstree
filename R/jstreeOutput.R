#' Shiny jstree output
#'
#' @param outputId jstree identification
#' @param checkbox TRUE/FALSE
#' @param search TRUE/FALSE
#' @param search_placeholder string
#'
#' @export
#' @importFrom shiny tagAppendChild tagList singleton
jstreeOutput <- function(outputId, checkbox=FALSE, search=FALSE, search_placeholder = ""){

    searchEl <- tags$div("")
    if (search == TRUE){
        search <- paste0(outputId, "-search-input")
        searchEl <- tags$input(id=search, class="form-control", type="text", value="")
    }
    if (is.character(search)){
        # Either the search field we just created or the given text field ID
        searchEl <- shiny::tagAppendChild(searchEl, tags$script(type="text/javascript", shiny::HTML(
            paste0("jstreeFun.initSearch('",outputId,"','",search,"');"))))
    }

    searchEl <- tags$div(
        class="form-group shiny-input-container",
        searchEl
    )

    shiny::tagList(
        shiny::singleton(tags$head(
            initResourcePaths(),
            tags$link(rel = 'stylesheet', type = 'text/css',
                             href = 'jstree/jsTree-3.3.4/themes/default/style.min.css'),
            tags$link(rel = 'stylesheet', type = 'text/css',
                             href = 'jstree/jstree.css'),
            tags$link(rel = "stylesheet", type = "text/css",
                             href = "shared/font-awesome/css/font-awesome.min.css"),
            tags$script(src = 'jstree/jsTree-3.3.4/jstree.min.js'),
            tags$script(src = 'jstree/jstree.js')
        )),
        searchEl,
        tags$div(id=outputId, class = "shiny-jstree",
                   `data-st-checkbox` = checkbox,
                   `data-st-search` = is.character(search))
    )
}