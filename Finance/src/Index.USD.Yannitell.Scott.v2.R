library("quantmod")
startDate = Sys.Date() - (365)
endDate = Sys.Date()

getSymbols( "EUR/USD", from= startDate, to = endDate, src = "oanda")
getSymbols( "GBP/USD", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/CAD", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/SEK", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/JPY", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/CHF", from= startDate, to = endDate, src = "oanda")
getSymbols( "SPY", from= startDate, to = endDate)


testStock <- SPY #this is the stock we are going to trade (possibly)

isValidDate <- function(symboly, date){
	indexy <- symboly[date,4]
	testCond <- TRUE
	dateCheck <- as.numeric(indexy)
	if (length(dateCheck) == 0)
		testCond <- FALSE
	return(testCond)
}

usdx <- 50.14348112 * (EURUSD^ (-0.576)) * 
		(USDJPY ^ 0.136) * (GBPUSD ^ (-0.119)) * 
		(USDCAD ^ 0.091) * (USDSEK ^ 0.042) * 
		(USDCHF ^ 0.036)

colnames(usdx) <- "USD Index"

usdxDailyChangePercentage <- 1:length(usdx)
myTimeSeriesDates <- as.Date(startDate) + 1:length(usdx) - 1
for (x in usdxDailyChangePercentage){
	if (x>1) usdxDailyChangePercentage[x] <- (1-(as.numeric(usdx[x-1])/as.numeric(usdx[x])))*100		
}

usdxDatesAndChanges <- zoo(usdxDailyChangePercentage,myTimeSeriesDates)
#plot(type="l",usdxDatesAndChanges)
#View(usdxDatesAndChanges)
DailyReturnPercentages <- 1:length(usdxDatesAndChanges)
for (x in 1:length(usdxDatesAndChanges)){
	DailyReturnPercentages[x] <- 0
	isStockTradingDay <- isValidDate(SPY, toString(time(EURUSD[x])))
	if (isStockTradingDay==TRUE && x > 1 && x < length(usdxDatesAndChanges)){
		#print("we'z be tradin today")
		#if the dollar weakened the day before we buy (at open) or hold
		#if the dollar gets stronger the day before we sell at the open hoping our profits are secured
		#then we gather the profit or the loss from the sale
		#this is where the hard stuff comes in :(
		theDay <- time(EURUSD[x])
		theNextDay <- time(EURUSD[x+1])
		theDayBefore <- time(EURUSD[x-1])
		DXchangeTheDayBefore <- as.numeric(usdxDatesAndChanges[theDayBefore])
		prevStockTradinDay <- which(index(testStock[theDay])==index(testStock))-1
		testStockChange <- (1-(as.numeric(testStock[prevStockTradinDay, 4])/as.numeric(testStock[theDay,4])))*100	
		#print(testStockChange)
		if (DXchangeTheDayBefore < 0){
			DailyReturnPercentages[x] <- testStockChange
			
		}
		
		#SPY["2011-01-24"]
		#           SPY.Open SPY.High SPY.Low SPY.Close SPY.Volume SPY.Adjusted
		#2011-01-24   128.29   129.25  128.26     129.1  113647600        129.1
	}
}
DailyReturnPercentages <- zoo(DailyReturnPercentages,myTimeSeriesDates)
View(DailyReturnPercentages)
overallReturn <- 1
for (x in 1:length(DailyReturnPercentages)){
	profitOrLoss = overallReturn * (as.numeric(DailyReturnPercentages[x])/100)
	#print(profitOrLoss)
	overallReturn <- overallReturn + profitOrLoss
}
overallReturn