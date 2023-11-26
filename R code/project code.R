setwd("C:/Users/GBEMY/Desktop/PROJECT FILES/project analysis")
data<-read.csv(file.choose(),header=T)
View(data)
attach(data)

library(INLA)
library(sf)
library(tmap)
library(spdep)
library(tidyverse)
library(leaflet)
library(ggplot2)

nigeria<- st_read("shps/sdr_subnational_boundaries.shp")
plot(nigeria, max.plot=10)
View(nigeria)
tm_shape(nigeria) + tm_borders()
temp <- poly2nb(nigeria)
View(temp)
nb2INLA("nigeria.graph",temp)
nig1 <- inla.read.graph("nigeria.graph")
View(nig1)
nigeria$ID <- nigeria$REGCODE/10

data$state <- data$state/10
data$state1 <- data$state

f1<- multiple_partners ~ factor(Age) + factor(first_sex) + factor(area) + factor(edu_level) +factor(Religion) + factor(Ethnic) + factor(internetuse) + factor(Marital_status) + factor(ehosti) + factor(gender) + f(state1,model = "besag",graph = nig1)
result1<- inla(f1,
                 family = "binomial",data=data,
                 control.compute = list(waic=T,dic=T,cpo=T))
summary(result1)

f2<- multiple_partners ~ factor(Age) + factor(first_sex) + factor(area) + factor(edu_level) +factor(Religion) + factor(Ethnic) + factor(internetuse) + factor(Marital_status) + factor(ehosti) + factor(gender) + f(state,model = "iid",graph = nig1)
result2<- inla(f2,
              family = "binomial",data=data,
              control.compute = list(waic=T,dic=T,cpo=T))
summary(result2)

f3<- multiple_partners ~ factor(Age) + factor(first_sex) + factor(area) + factor(edu_level) +factor(Religion) + factor(Ethnic) + factor(internetuse) + factor(Marital_status) + factor(ehosti) + factor(gender) + f(state,model = "iid",graph = nig1)+ f(state1,model = "besag",graph = nig1)
result3<- inla(f3,
               family = "binomial",data=data,
               control.compute = list(waic=T,dic=T,cpo=T))

summary(result3)

f4<- multiple_partners ~ f(state1,model = "besag",graph = nig1)
result4<- inla(f4,
               family = "binomial",data=data,
               control.compute = list(waic=T,dic=T,cpo=T))
summary(result4)

g1<- mpis ~ factor(Age) + factor(first_sex) + factor(area) + factor(edu_level) +factor(Religion) + factor(Ethnic) + factor(internetuse) + factor(Marital_status) + factor(ehosti) + factor(gender) + f(state1,model = "besag",graph = nig1)

r1<- inla(g1,
               family = "binomial",data=data,
               control.compute = list(waic=T,dic=T,cpo=T))
summary(r1)

g2<- mpis ~ factor(Age) + factor(first_sex) + factor(area) + factor(edu_level) +factor(Religion) + factor(Ethnic) + factor(internetuse) + factor(Marital_status) + factor(ehosti) + factor(gender) + f(state,model = "iid",graph = nig1)
r2<- inla(g2,
               family = "binomial",data=data,
               control.compute = list(waic=T,dic=T,cpo=T))
summary(r2)

g3<- mpis ~ factor(Age) + factor(first_sex) + factor(area) + factor(edu_level) +factor(Religion) + factor(Ethnic) + factor(internetuse) + factor(Marital_status) + factor(ehosti) + factor(gender) + f(state,model = "iid",graph = nig1)+ f(state1,model = "besag",graph = nig1)
r3<- inla(g3,
               family = "binomial",data=data,
               control.compute = list(waic=T,dic=T,cpo=T))


summary(r3)

g4<- mpis ~ f(state1,model = "besag",graph = nig1)
r4<- inla(g4,family = "binomial",data=data,control.compute = list(waic=T,dic=T,cpo=T))

summary(r4)

View(result1$summary.fixed)
View(result4$summary.fixed)
View(r1$summary.fixed)
View(r4$summary.fixed)
write.csv(result1$summary.fixed,'C:/Users/GBEMY/Desktop/PROJECT FILES/project analysis/mupa~covariates.csv')
write.csv(result4$summary.fixed,'C:/Users/GBEMY/Desktop/PROJECT FILES/project analysis/mupa~besag.csv')
write.csv(r1$summary.fixed,'C:/Users/GBEMY/Desktop/PROJECT FILES/project analysis/mpis~covariates.csv')
write.csv(r4$summary.fixed,'C:/Users/GBEMY/Desktop/PROJECT FILES/project analysis/mpis~besag.csv')

fit <- r4$summary.random$state
fit1 <- result4$summary.random$state1
fit2<- r1$summary.random$state
fit3 <- result1$summary.random$state
map1 <- inner_join(nigeria,fit)
map2 <- inner_join(nigeria,fit1)
map3 <- inner_join(nigeria,fit2)
map4 <- inner_join(nigeria,fit3)
View(map1)
View(map2)
View(map3)
View(map4)


ggplot(map1)+geom_sf(aes(fill=exp(mean)))+scale_fill_gradient2(low = "blue",mid = "white",high = "red")+labs(title = "Last-12-months~besag(state)")+theme_bw()
ggplot(map2)+geom_sf(aes(fill=exp(mean)))+scale_fill_gradient2(low = "blue",mid = "white",high = "red")+labs(title = "total-lifetime~besag(state)")+theme_bw()
ggplot(map3)+geom_sf(aes(fill=exp(mean)))+scale_fill_gradient2(low = "blue",mid = "white",high = "red")+labs(title = "Last-12-months~covariates+besag(state)")+theme_bw()
ggplot(map4)+geom_sf(aes(fill=exp(mean)))+scale_fill_gradient2(low = "blue",mid = "white",high = "red")+labs(title = "total-lifetime~covariates+besag(state)")+theme_bw()

