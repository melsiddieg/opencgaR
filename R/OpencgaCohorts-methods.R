#' @title A method to query Opencga cohorts
#' @aliases OpencgaCohorts
#' @description This method allow the user to create, update and explore
#' cohorts data and metadta
#' @export
setMethod("OpencgaCohorts", "Opencga",    definition = function(object,
                                                                id, action, params, ...){
  category <- "cohorts"
  data <- excuteOpencga(object=object, category=category, id=id, action=action,
                        params=NULL, ...)
  return(data)
})