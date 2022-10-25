
d <- readRDS("summarySCC_PM25.rds")

#========================
# Total by year
#========================


yrTotals <- with(d, tapply(Emissions,year,sum,na.rm=TRUE))

png(filename="plot1.png")

plot(as.numeric(names(yrTotals)),
     yrTotals,
     t="l",
     col="blue",
     lwd=2,
     xlab="Year",
     ylab="Tons PM2.5",
     main="National Pollution Totals")

dev.off()

