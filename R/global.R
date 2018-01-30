library(data.table)
# Sys.setenv(JAVA_HOME='/usr/lib/jvm/java-9-openjdk-amd64')
# install.packages(c("rJava","xlsx","RDS"))
library(rJava)#https://www.r-statistics.com/2012/08/how-to-load-the-rjava-package-after-the-error-java_home-cannot-be-determined-from-the-registry/
library(xlsx)
# download.file(url = "http://biogeo.ucdavis.edu/data/gadm2.8/rds/FRA_adm1.rds",destfile = "departements.rds")
library(RDS)
library(sp)
library(stringi)
library(dplyr)
library(leaflet)
path_to_data=gsub(x = system("find . -name Indicateurs_VQS_Dep.xlsx",intern = T),pattern = "Indicateurs_VQS_Dep.xlsx",replacement = "")
indicateurs=read.xlsx(paste0(path_to_data,"Indicateurs_VQS_Dep.xlsx"),sheetIndex = 1)
load(paste0(path_to_data,"FR_gadm.RData"))
nm_dep=names(indicateurs)[1]
setnames(indicateurs,nm_dep,"departement")
indicateurs$departement=as.character(indicateurs$departement)
indicateurs=indicateurs[!is.na(indicateurs$departement),]
indicateurs[stri_length(indicateurs$departement)==1,]$departement=paste0("0",indicateurs[stri_length(indicateurs$departement)==1,]$departement)
FRA_dep@data=merge(FRA_dep@data,indicateurs,by.x="CCA_2",by.y="departement")
FRA_dep_10pct@data=merge(FRA_dep_10pct@data,indicateurs,by.x="CCA_2",by.y="departement")
FRA_dep_1pct@data=merge(FRA_dep_1pct@data,indicateurs,by.x="CCA_2",by.y="departement")
FRA_dep_list=list("pct100"=FRA_dep,"pct10"=FRA_dep_10pct,"pct1"=FRA_dep_1pct)

FRA_dep_1pct@data[,c("NAME_2","CCA_2")]


