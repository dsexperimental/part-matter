library(dplyr)

d <- readRDS("summarySCC_PM25.rds")

#========================
# Baltimore totals by year
#========================
dBalt <- filter(d,fips == 24510)
yrTotalsBalt <- with(dBalt, tapply(Emissions,year,sum,na.rm=TRUE))

png(filename="plot2.png")

plot(as.numeric(names(yrTotalsBalt)),
     yrTotalsBalt,
     t="l",
     col="blue",
     lwd=2,
     xlab="Year",
     ylab="Tons PM2.5",
     main="Baltimore Pollution Totals")

dev.off()

