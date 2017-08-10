#' @title A method to query Opencga Variables
#' @aliases OpencgaVariables
#' @description This method allow the user to create, update and explore
#' vaiables data and metadta
#' @export
setMethod("OpencgaVariableSet", "Opencga",    definition = function(object,
                                                                  id, action, params, ...){
  category <- "variableSet"
  data <- excuteOpencga(object=object, category=category, id=id, action=action,
                        params=NULL, ...)
  return(data)
})