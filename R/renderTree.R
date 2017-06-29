#' @export
renderTree <- function(expr, env = parent.frame(), quoted = FALSE){

    func <- shiny::exprToFunction(expr, env, quoted)

    return(function(shinysession, name, ...) {

        jsonlite::toJSON(func(), auto_unbox = TRUE)
    })
}