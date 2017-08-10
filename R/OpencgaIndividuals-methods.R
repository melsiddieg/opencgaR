#' @title A method to query Opencga Individuals
#' @aliases OpencgaIndividuals
#' @description This method allow the user to create, update and explore
#' Individuals data and metadta
#' @export
setMethod("OpencgaIndividuals", "Opencga",    definition = function(object,
                                                                    id=NULL, action, params, ...){
  category <- "individuals"
  if(is.null(id)){
    id <- NULL
  }
  if(is.null(params)){
    params <- NULL
  }
  data <- excuteOpencga(object=object, category=category, id=id, action=action,
                        params=NULL, ...)
  return(data)
})
