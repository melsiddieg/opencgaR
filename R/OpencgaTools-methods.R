#' @title A method to query Opencga Tools
#' @aliases OpencgaCohorts
#' @description This method allow the user to create, update and explore
#' cohorts data and metadta
#' @export
setMethod("OpencgaTools", "Opencga",    definition = function(object,
                                                                id, action, params, ...){
  category <- "tools"
  data <- excuteOpencga(object=object, category=category, id=id, action=action,
                        params=NULL, ...)
  return(data)
})