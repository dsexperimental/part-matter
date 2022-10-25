library(dplyr)

d <- readRDS("summarySCC_PM25.rds")

#========================
## autos in baltimore
#========================

# get on road emissions for Baltimore
onRoadBalt <- filter(d,(fips == "24510") & (type == "ON-ROAD"))
onRoadTotalsBalt <- with(onRoadBalt, tapply(Emissions,year,sum,na.rm=TRUE))

png(filename="plot5.png")

plot(names(onRoadTotalsBalt),
     onRoadTotalsBalt,
     t="l",
     col="blue",
     lwd=2,
     xlab="Year",
     ylab="Tons PM2.5",
     main="Motor Vehicle Pollution in Baltimore")

dev.off()
