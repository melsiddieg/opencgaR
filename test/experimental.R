source("R/utils.R")
test <- cgaHelp()
tags <-test$tags
paths <- names(test$paths)
api <- test$api
str(api,1)
sapply(paths, function(x)countSections(x))
paths[sapply(paths, countSections)>7]
paths[sapply(paths, countSections)>6]
paths[sapply(paths, countSections)>7]
grep('studies', paths[sapply(paths, countSections)>6], value = T)
grep('variables', paths[sapply(paths, countSections)>5], value = T)
grep('files', paths[sapply(paths, countSections)>5], value = T)
