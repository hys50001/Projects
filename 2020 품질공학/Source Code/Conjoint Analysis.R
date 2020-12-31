library(conjoint)
library(readxl)
library(dplyr)

experiment= expand.grid(
  
  type=c("산업재생","문화재생", "역사재생", "주거재생"),
  
  size=c("소","중","대"),
  
  operating_entity=c("민간", "공공기관"),
  
  specialize_factor=c("기존용도활용","용도변경"),
  purpose=c("다목적문화공간","골목상권","박물관,역사유적"))

design<-caFactorialDesign(data=experiment, type="full")
design_sort=design[order(design$type,design$size,design$operating_entity,
                         design$specialize_factor),];row.names(design_sort)<-NULL
profile<-design_sort[c(90,88,87,96,93,91,73,76,101,108,106,98,102,100,
                       16,26,31,21,22,4,
                       70,52,61,55,58,64,
                       134,120,118,115,114,130,132,122),]
profile
code<-caEncodedDesign(profile) #matrix of profiles
preference<-read_excel('score_100.xlsx')
preference<-t(preference) 
level<-c("산업재생","문화재생", "역사재생", "주거재생", "소","중","대","민간","공공기관",
         "기존용도활용","용도변경", "다목적문화공간","골목상권","박물관,역사유적")
Conjoint(preference,code,level,y.type='score')
