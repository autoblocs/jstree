#' @export
setNode <- function(x = "", sticon = NULL, stselected = FALSE, stdisabled = FALSE,
                    stopened = FALSE){

    structure(x, sticon = sticon, stselected = stselected, stdisabled = stdisabled,
              stopened = stopened)

}