#' set jstree node
#'
#' @param x string
#' @param children setNode object, list os setNodes or empty list
#' @param icon Font Awesome icon
#' @param stopened TRUE/FALSE
#' @param stselected TRUE/FALSE
#' @param stdisabled TRUE/FALSE
#'
#' @export
setNode <- function(x, children = list(), icon = NULL,
                        stopened = FALSE, stselected = FALSE, stdisabled = FALSE){
    list(
        text = x,
        icon = ifelse(is.null(icon), "", paste0("fa fa-", icon)),
        state = list(opened = stopened,
                     selected = stselected,
                     disabled = stdisabled),
        children = children
    )
}