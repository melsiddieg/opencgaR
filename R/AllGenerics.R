setGeneric("OpencgaUser", function(object, category, id=NULL, action, params=NULL,...)
  standardGeneric("OpencgaUser"))

setGeneric("OpencgaStudy", function(object, id, category="studies",action, 
                                    params=NULL,acl=NULL, memberID=NULL,
                                    groups=NULL, groupID=NULL, ...)
  standardGeneric("OpencgaStudy"))

setGeneric("OpencgaProjects", function(object, id=NULL, action, params=NULL, ...)
  standardGeneric("OpencgaProjects"))

setGeneric("OpencgaFiles", function(object, id=NULL, action, params=NULL, ...)
  standardGeneric("OpencgaFiles"))

setGeneric("OpencgaSamples", function(object, id=NULL, action, params=NULL, ...)
  standardGeneric("OpencgaSamples"))

setGeneric("OpencgaIndividuals", function(object, id=NULL, action, params, ...)
  standardGeneric("OpencgaIndividuals"))

setGeneric("OpencgaJobs", function(object, id, action, params, ...)
  standardGeneric("OpencgaJobs"))

setGeneric("OpencgaVariableSet", function(object, id, action, params, ...)
  standardGeneric("OpencgaVariableSet"))

setGeneric("OpencgaCohorts", function(object, id, action, params, ...)
  standardGeneric("OpencgaCohorts"))

setGeneric("OpencgaPanels", function(object, id, action, params, ...)
  standardGeneric("OpencgaPanels"))

setGeneric("OpencgaAnalysis-Alignment", function(object, id, action, params, ...)
  standardGeneric("OpencgaAnalysis-Alignment"))

setGeneric("OpencgaAnalysisVariant", function(object, id, action, params, ...)
  standardGeneric("OpencgaAnalysisVariant"))

setGeneric("OpencgaTools", function(object, id, action, params, ...)
  standardGeneric("OpencgaTools"))
