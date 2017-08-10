#' @title A method to query Opencga Samples
#' @aliases OpencgaSamples
#' @description This method allow the user to create, update and explore
#' Samples data and metadta
#' @export
setMethod("OpencgaSamples", "Opencga",    definition = function(object,
                                                                id=NULL, action, params=NULL, ...){
  category <- "samples"
  if(is.null(id)){
    id <- NULL
  }
  if(is.null(params)){
    params <- NULL
  }
  data <- excuteOpencga(object=object, category=category, id=id, action=action,
                        params=params, ...)
  return(data)
})