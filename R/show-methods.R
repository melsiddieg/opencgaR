
setMethod("show",signature = "Opencga",definition = function(object){
  cat("|An object of class ", class(object), "\n", sep = "")
  cat("|This object is required by all Opencga Methods")
})
