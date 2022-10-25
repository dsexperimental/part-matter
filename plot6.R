library(dplyr)
library(stringr)

d <- readRDS("summarySCC_PM25.rds")

#========================
## autos in baltimore vs LA
#========================

# get on road emissions for Baltimore
onRoadBalt <- filter(d,(fips == "24510") & (type == "ON-ROAD"))
onRoadTotalsBalt <- with(onRoadBalt, tapply(Emissions,year,sum,na.rm=TRUE))

# get on road emissions for LA
onRoadLA <- filter(d,(fips == "06037") & (type == "ON-ROAD"))
onRoadTotalsLA <- with(onRoadLA, tapply(Emissions,year,sum,na.rm=TRUE))

# noramlize results by 1999 values for comparison
fracOnRoadTotalsBalt = onRoadTotalsBalt / onRoadTotalsBalt[1]
fracOnRoadTotalsLA = onRoadTotalsLA / onRoadTotalsLA[1]

rng <- range(fracOnRoadTotalsBalt,fracOnRoadTotalsLA,c(0))

png(filename="plot6.png")

plot(as.numeric(names(fracOnRoadTotalsBalt)),
     fracOnRoadTotalsBalt,
     t="l",
     col="blue",
     lwd=2,
     xlab="Year",
     ylab="Tons PM2.5 / 1999 Tons PM2.5",
     ylim = rng,
     main="Normalized MV Emissions of LA and Balt.")
points(as.numeric(names(fracOnRoadTotalsLA)),
       fracOnRoadTotalsLA,
       t="l",
       col="red",
       lwd=2)
legend("bottomleft", lwd=2, col = c("blue", "red"), legend = c("Baltimore","LA"))

dev.off()





