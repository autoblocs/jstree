#' @export
renderTree <- function(expr, env = parent.frame(), quoted = FALSE){

    func <- shiny::exprToFunction(expr, env, quoted)

    return(function(shinysession, name, ...) {

        tree <- func()

        shiny::HTML(as.character(listToTags(tree)))
    })
}

#' @export
renderTreeJson <- function(expr, env = parent.frame(), quoted = FALSE){

    func <- shiny::exprToFunction(expr, env, quoted)

    return(function(shinysession, name, ...) {

        func()
    })
}