#' Render shiny jstree output
#'
#' @param expr r expression
#' @param env r environment
#' @param quoted TRUE/FALSE
#'
#' @export
#' @importFrom shiny exprToFunction
#' @importFrom jsonlite toJSON
renderTree <- function(expr, env = parent.frame(), quoted = FALSE){

    func <- shiny::exprToFunction(expr, env, quoted)

    return(function(shinysession, name, ...) {

        jsonlite::toJSON(func(), auto_unbox = TRUE)
    })
}