library(opencgaR)
 base <- "http://localhost:8080/opencga-1.1.2/webservices/rest/v1"
# http://localhost:8080/opencga-1.0.0-rc3/webservices
cga <- cgalogin(baseurl=base,  username = "mcga", password = '1234')
res1 <- OpencgaStudy(object = cga, id = '10k', action = "files")

# cga <- OpencgaLogin(baseurl = base,interactive = T)
userProj <- OpencgaUser(cga, category = "user", id="mcga",action = "projects")

sampledata <- OpencgaStudy(object = cga, id = '1kG_phase3', action = "samples")
sampledata <- OpencgaStudy(object = cga, id = '10k', action = "samples")
studyFiles <- OpencgaStudy(object = cga, id = '1kG_phase3', action = "files")
studyInfo <- OpencgaStudy(object = cga, id = '1k', action = "info")
userinfo <- OpencgaUser(object = cga, id = "mcga", action = "info")
filesformats <- OpencgaFiles(object = cga, action = "formats")
studyACL <- OpencgaStudy(cga, id = '1k', action = 'acl')
study_summary <- OpencgaStudy(cga, id='1kG_phase3', action = 'summary')
#study_jobs <- OpencgaStudy(cga,  action = 'jobs')
test <- OpencgaAnalysisVariant(object = cga, id = NULL, action = 'query' ,
                               params=NULL, studies='1k'
                               ,limit=120 )
test2 <- OpencgaAnalysisVariant(object = cga, id = NULL, action = 'query' ,
                               params=NULL, studies='gwas'
                               ,limit=120 )
library(tidyverse)
tcol <- map(test$annotation.populationFrequencies, function(x)x[1,5])
tcol
find_freq <- function(x, study='GNOMAD_GENOMES',population="AFR", col="altAlleleFreq"){
  row <- which(pop_freq$study==study&pop_freq$population==population)
  res <- x[row, col]
  res
}
gnomad_afr_allele <- map_dbl(test$annotation.populationFrequencies, function(x)find_freq(x,col="altAlleleFreq"))
kg_afr_allele <- map_dbl(test$annotation.populationFrequencies, function(x)find_freq(x,study='1kG_phase3'))
afrl <- cbind(gnomad_afr_allele, kg_afr_allele)
afrl <- as.tibble(afrl)
ts2 <-OpencgaAnalysisVariant(object = cga, id = NULL, action = 'query',
                             params=NULL, studies='1k', 
                             limit=12 )
caddscores <- test$annotation.functionalScore[[1]]
conseq <- test$annotation.consequenceTypes[[1]]
pop_freq <- test$annotation.populationFrequencies[[1]]
conser <- test$annotation.conservation[[1]]
asoc <- test$annotation.geneTraitAssociation[[10]]
drgs <- test$annotation.geneDrugInteraction[[111]]
vs <- OpencgaAnalysisVariant(object = cga, id = '1kg',action = 'stats', params = NULL)
### fetch variants from a file
# get all the variants
system.time({
  test <- OpencgaFiles(object = cga, id = 60, action = "variants")
  
})
# construct a variantParam
filt <- cgaVariantParam(region = "1:10522:17522")
#
system.time({
  filteredVars <- OpencgaFiles(cga, id = 60, action = "variants", params = filt)
  })

# A test to create a new project
# get the neccessary help
proj <- getOpencgaDocs(category = "projects", action = "create", requiredOnly = T)
# Hope
hop <- OpencgaProjects(object = cga, id = NULL, action = "create", params = NULL,
                       name="Sudan3" ,alias="Sudanes", organization="Opencb")
# Another test
hop2 <- OpencgaProjects(object = cga, action = "create",  name="Sudan2" ,
                        alias="Sudanese2", organization="Opencb")
#
# create  A New study
# get help on the arguments to create a a study
sth <- getOpencgaDocs(category = "studies", action = "create")
#
# file linking
test <- OpencgaFiles(object = cga, id=NULL, params=NULL, 
                     action="relink", uri="/home/sieny/Data/opencb/hapmap_exome_chr22.vcf.gz",
                     studyId=3, path="data/")



system.time({
  test2 <- OpencgaFiles(object = cga, id = 32, action = "variants")
})

files <- OpencgaStudy(object = cga, id = 3, action = "files")
info <- OpencgaStudy(object = cga, id = 3, action = "info")
samples <- OpencgaStudy(object = cga, id = 3, action = "samples")

filvar <- OpencgaFiles(object = cga, id = 8, action = "variants")

summ <- OpencgaStudy(cga, id = 2, action = "summary")




library(jsonlite)
drl <- "http://localhost:8080/opencga/webservices/rest/swagger.json"
res <- fromJSON(drl)
str(res,1)
apis <- res$paths
str(apis,1)
#
#
cgaHelp <- function(object, category, action, resource=NULL){
  host <- object@baseurl
  cbDocsUrl <- gsub("v1", "swagger.json", host)
  Data <- fromJSON(cbDocsUrl)
  tags <- Data$tags
  paths <- Data$paths
  getList <- lapply(paths, function(x)x$get)
  ## filtered
  parts <- Filter(Negate(function(x) is.null(unlist(x))), getList)
  cbGetParams <- lapply(parts, function(x)x$parameters)
  catact <- paste0(category, "\\{.*?\\}?","/", action)
  index <- grep(catact, names(cbGetParams))
  narrowed <- names(parts)[index]
  # patt1 <- paste0(catsub, "/.*?/","(.*)" )
  resMatch <- regexec(catact,narrowed)
  m <- regmatches(narrowed, resMatch)
  if(is.null(resource)){
    res <- sapply(m, function(x)x[2])
    res <- res[!is.na(res)]
  }else{
    patt2 <- paste(catsub,"/", ".*?/", resource, sep="")
    index <- grep(patt2, names(parts))
    res <- parts[[index]]
    res <- res$parameters
    res <- subset(res,!(name %in% c("version", "species")), select=c("name", "description","required", "type"))
  }
  res
}

category <- "studies"
action <- "create"
host <- cga@baseurl
cbDocsUrl <- gsub("v1", "swagger.json", host)
Data <- fromJSON(cbDocsUrl)
tags <- Data$tags
paths <- Data$paths
getList <- lapply(paths, function(x)x$get)
## filtered
parts <- Filter(Negate(function(x) is.null(unlist(x))), getList)
cbGetParams <- lapply(parts, function(x)x$parameters)
catact <- paste0(category, "(.*?)", action)
index <- grep(catact, names(cbGetParams))
res <- parts[[index]]
res <- res$parameters
res <- subset(res,!(name %in% c("version", "species")), select=c("name", "description","required", "type"))
res

#### toy with sparkR

Sys.setenv(SPARK_HOME = "/home/sieny/Applications/spark-2.1.1-bin-hadoop2.7")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))  
library(SparkR)
sparkR.session(appName = "R Spark SQL basic example", sparkConfig = list(spark.some.config.option = "some-value"))
json_variants <- toJSON(test)
write(json_variants, 'test.json')
vart <- read.df('test.json', 'json')
printSchema(vart)
createOrReplaceTempView(vart, "variants")
library(listviewer)
jsonedit(test)
# to be solved
# see https://docs.databricks.com/spark/latest/spark-sql/complex-types.html#transform-complex-data-types-sql
dems <- sql("select chromosome, alternate, reference,
        annotation.populationFrequencies.altAlleleFreq[0] As T
            from variants limit 10")
head(dems)

s1 <- sql("SELECT chromosome, start, end, type, studies.samplesData[0][0][0] AS GT1
          FROM variants")
head(s1)
s2 <- sql("SELECT chromosome, start, end, type, studies.samplesData[0][0][0] AS GT1, 
           explode(annotation.populationFrequencies) AS pop  FROM variants")

# showDF(sql(sqlContext, "SELECT chromosome, start, end, type, annotation.consequenceTypes[0].geneName AS consequnce FROM vars 
#             WHERE annotation.consequenceTypes IS NOT NULL limit 5"))

#
s3 <- sql("SELECT chromosome,type, count(*) as count FROM variants GROUP BY chromosome, type")
head(s3)
# Another file Now fully annotated
# run listviewr and jsonedit
s5 <- sql("SELECT  annotation.populationFrequencies.population[0] AS t
           FROM variants")
head(s5)

s1 <- sql("SELECT chromosome,start, end, type, explode(annotation.populationFrequencies.altAlleleFreq) AS AlleleFreq from vars")

s4 <- sql("SELECT chromosome,start, end, type, explode(annotation.populationFrequencies.altAlleleFreq) AS AlleleFreq from variants")
#) AS minfreq  from vars"))
#
t1 <- sql("SELECT count(*) AS count, studies.samplesData[0][0][0] AS GT1 FROM variants GROUP BY studies.samplesData[0][0][0]")
head(t1)
#
t2 <- sql("SELECT chromosome,start, end, type, studies.samplesData[0][3] AS studies from variants")
head(t2)
t3 <- sql("SELECT chromosome, start,end, explode(studies.samplesData[0]) from variants")
head(t3)
