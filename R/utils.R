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