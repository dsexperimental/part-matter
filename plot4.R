library(dplyr)
library(stringr)

md <- readRDS("Source_Classification_Code.rds")
d <- readRDS("summarySCC_PM25.rds")

#========================
## coal
#========================

#get SCC values for "Fuel Combustion...Coal"
cl <- sapply(md$EI.Sector,function(val) {str_detect(val,regex("(^Fuel)*Coal"))})

coalSector = md$EI.Sector[cl]
coalNum = md$SCC[cl]

dCoal <- filter(d,SCC %in% coalNum)

yrTotalsCoal = with(dCoal, tapply(Emissions,year,sum,na.rm=TRUE))

png(filename="plot4.png")

plot(as.numeric(names(yrTotalsCoal)),
     yrTotalsCoal,
     t="l",
     col="blue",
     lwd=2,
     xlab="Year",
     ylab="Tons PM2.5",
     main="Pollution from Coal Combustion")

dev.off()