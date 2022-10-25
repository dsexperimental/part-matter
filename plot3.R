library(dplyr)
library(stringr)
library(ggplot2)

d <- readRDS("summarySCC_PM25.rds")

#========================
# Baltimore totlas by year, type
#========================

dBalt <- filter(d,fips == 24510)

##add a type.year column
dBalt$type.year <- factor(paste(dBalt$type,dBalt$year,sep="."))

yrTypeTotalsBalt = with(dBalt, tapply(Emissions,type.year,sum,na.rm=TRUE))

#reconstruct a data frame of emissions versus type and year
nms= strsplit(names(yrTypeTotalsBalt),".",fixed=TRUE)
types = factor(sapply(nms,function(v) {v[1]}))
yrs = as.numeric(sapply(nms,function(v) {v[2]}))
yttbdf = data.frame(year = yrs, type = types, Emissions = yrTypeTotalsBalt)

png(filename="plot3.png")

ggplot(yttbdf,aes(x = year, y = Emissions)) + 
  geom_line() + 
  geom_point() + 
  facet_grid(type ~ .) + 
  labs(title="Emissions by Type for Baltimore")

dev.off()
