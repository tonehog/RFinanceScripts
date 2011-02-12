#library("quantmod")
#chartSeries(DJI, theme="white",TA="addVo(); addBBands(); addCCI()")
#chartSeries(GDP, TA="addVo(); addBBands(); addCCI()")
#price.xauusd <- as.numeric(XAUUSD$XAU.USD)
#price.djia <- as.numeric(DJI$DJI.Open)
#price.DJIvsXAU <- FALSE 
#price.date <- index(DJI)
#price <- as.xts(c(price.date, price.djia, price.xauusd))

#############################################################################
#
#	Begin Here
#
#############################################################################
library("quantmod")

# get the data
getSymbols("DEXUSEU",src="FRED")
DEXUSEU <- DEXUSEU['2009-01-01::']

getSymbols('.DJI', src="google")
DJI <- DJI['2009-01-01::']

getSymbols("CPIAUCSL", src="FRED")
CPIAUCSL <- CPIAUCSL['2009-01-01::']

# plotting time
layout(1:3) # 1 col, 2 rows
plot(DEXUSEU, main="Euro vs. Dollar")
plot(DJI, main="Dow Jones Industrial Average")
plot(CPIAUCSL, main="Consumer Price Index")

chartSeries(DEXUSEU,
			name="EUR/USD Echange Rate",
			type="candlesticks",
			theme="white",
			plot=TRUE)
addBBands(n=96,
		  maType="EMA")
addCCI(n=96,
		maType="EMA",
		c=0.015)

