library("quantmod")

startDate = Sys.Date() - (499)#500 days ago
endDate = Sys.Date()

getSymbols( "USD/XAU", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/XAG", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/EUR", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/GBP", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/CAD", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/AUD", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/JPY", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/CHF", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/CNY", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/BRL", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/RUB", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/MXN", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/KRW", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/IDR", from= startDate, to = endDate, src = "oanda")
getSymbols( "USD/INR", from= startDate, to = endDate, src = "oanda")

getSymbols( "SPY", from= startDate, to = endDate,)




symbolPercentageChange <- function(symbol){
	a <- symbol[[beginDay]]
	b <- symbol[[endDay]]
	return((1-(a/b))*100)
}

stockSymbolPercentageChange <- function(symbol){
	print(symbol[1])
}

USGDP = 14624184
EUGDP = 16106896 ##european Union
CNGDP = 5745133 ##China
JPGDP = 5390897 ##Japan
UKGDP = 2258565 ##Pound
BZGDP = 2023528 ##Brazil
CDGDP = 1563664 ##Canada
RSGDP = 1476912 ##Russia
INGDP = 1430020 #india waaah
AUGDP = 1219722 ##Australia 
MXGDP = 1004042 ##Mexico
SKGDP = 986256  ##south Korea
IAGDP = 695059  ##Indonisia
SZGDP = 522435  ##Switzerland
GDPbesidesUSA = EUGDP + CNGDP + JPGDP + UKGDP + BZGDP + CDGDP + RSGDP + INGDP + 
		AUGDP + MXGDP + SKGDP + IAGDP + SZGDP

GDPbesidesUSA
EUweight = EUGDP / GDPbesidesUSA
CNweight = CNGDP / GDPbesidesUSA
JPweight = JPGDP / GDPbesidesUSA
UKweight = UKGDP / GDPbesidesUSA
BZweight = BZGDP / GDPbesidesUSA
CDweight = CDGDP / GDPbesidesUSA
RSweight = RSGDP / GDPbesidesUSA
INweight = INGDP / GDPbesidesUSA
AUweight = AUGDP / GDPbesidesUSA
MXweight = MXGDP / GDPbesidesUSA
SKweight = SKGDP / GDPbesidesUSA
IAweight = IAGDP / GDPbesidesUSA
SZweight = SZGDP / GDPbesidesUSA
EUweight + CNweight + JPweight + UKweight + BZweight + CDweight + RSweight + INweight + 
		AUweight + MXweight + SKweight + IAweight + SZweight

weeklyDollarStrengthChange <-  1:70

weeklyDollarStrengthChange

for (x in weeklyDollarStrengthChange){
	
	beginDay = x*7
	endDay = x*7+7
	
	#DollarToGoldChange <- symbolPercentageChange(USDXAU)
	#DollarToSiverChange <- symbolPercentageChange(USDXAG)
	DollarToEuroChange <- symbolPercentageChange(USDEUR)
	DollarToPoundChange <- symbolPercentageChange(USDGBP)
	DollarToLoonieChange <- symbolPercentageChange(USDCAD)
	DollarToAussieChange <- symbolPercentageChange(USDAUD)
	DollarToYenChange <- symbolPercentageChange(USDJPY)
	DollarToSFrancChange <- symbolPercentageChange(USDCHF)
	DollarToYuanChange <- symbolPercentageChange(USDCNY)
	DollarToRealChange <- symbolPercentageChange(USDBRL)
	DollarToRoubleChange <- symbolPercentageChange(USDRUB)
	DollarToPesoChange <- symbolPercentageChange(USDMXN)
	DollarToWonChange <- symbolPercentageChange(USDKRW)
	DollarToRupiahChange <- symbolPercentageChange(USDIDR)
	DollarToRupeeChange <- symbolPercentageChange(USDINR)
	
	DollarStrengthChange = (DollarToEuroChange*EUweight)+
			(DollarToYuanChange*CNweight)+
			(DollarToYenChange*JPweight)+
			(DollarToRealChange*BZweight)+
			(DollarToLoonieChange*CDweight)+
			(DollarToRoubleChange*RSweight)+
			(DollarToRupeeChange*INweight)+
			(DollarToAussieChange*AUweight)+
			(DollarToPesoChange*MXweight)+
			(DollarToWonChange*SKweight)+
			(DollarToRupiahChange*IAweight)+
			(DollarToSFrancChange*SZweight)	
	weeklyDollarStrengthChange[x] <-DollarStrengthChange
}
SPYweeklyPercentageChange <- 1:67
for (y in SPYweeklyPercentageChange){
	a <- SPY[[y*5,4]]
	b <- SPY[[y*5+5,4]]
	spychange <- (1-(a/b))*100
	SPYweeklyPercentageChange[y] <-spychange
}

inverseTest <- 1:66
trueCount<-0
falseCount<-0
myReturn<-0
for (z in inverseTest){
	
	####test <- weeklyDollarStrengthChange[z] < SPYweeklyPercentageChange[z + 1]
	
	#I need to that if:
	#the dollar change index goes negative
	#does the SPY change go positive?
	dollarGoNegative <- FALSE
	spyGoPositive <- FALSE
	test <- FALSE
	print(weeklyDollarStrengthChange[z])
	print(SPYweeklyPercentageChange[z + 1])
	if (weeklyDollarStrengthChange[z]<0)
		dollarGoNegative <- TRUE
	
	if (SPYweeklyPercentageChange[z + 1]>0)
		spyGoPositive <- TRUE
	
	if (dollarGoNegative==TRUE && spyGoPositive==TRUE)
		test <- TRUE
	
	
	if (test == TRUE)
		myReturn<-myReturn+SPYweeklyPercentageChange[z + 1]
	
	
	
	print(c("test: ", test))
	if (test==TRUE) 
		trueCount<-trueCount+1
	
	
	if (test==FALSE)
		falseCount<-falseCount+1
}
print(c("trueCount", trueCount))
print(c("falseCount", falseCount))
print(c("myReturn", myReturn))