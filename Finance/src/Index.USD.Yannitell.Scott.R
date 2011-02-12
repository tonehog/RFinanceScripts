# TODO: Add comment
# 
# Authors: 	Scott Yannitell
#			Jerold Haas
#
# Version:	0.0.2
#				Re-sorted for running complete script
#				Added object removal and garbage collection
###############################################################################


library("quantmod")

symbolPercentageChange <- function(symbol){
	a <- symbol[[1]]
	b <- symbol[[length(symbol)]]
	return((1-(a/b))*100)
}

startDate <- Sys.Date() - 1
endDate <- Sys.Date()

getSymbols( "USD/XAU", from= startDate, to = endDate, src = "oanda")	#Gold
getSymbols( "USD/XAG", from= startDate, to = endDate, src = "oanda")	#Silver
getSymbols( "USD/EUR", from= startDate, to = endDate, src = "oanda")	#Euro
getSymbols( "USD/GBP", from= startDate, to = endDate, src = "oanda")	#Pound
getSymbols( "USD/CAD", from= startDate, to = endDate, src = "oanda")	#Canadian
getSymbols( "USD/AUD", from= startDate, to = endDate, src = "oanda")	#Aussie
getSymbols( "USD/JPY", from= startDate, to = endDate, src = "oanda")	#Yen
getSymbols( "USD/CHF", from= startDate, to = endDate, src = "oanda")	#Franc
getSymbols( "USD/CNY", from= startDate, to = endDate, src = "oanda")	#Yuan
getSymbols( "USD/BRL", from= startDate, to = endDate, src = "oanda")	#Brazil?
getSymbols( "USD/RUB", from= startDate, to = endDate, src = "oanda")	#Rubles?
getSymbols( "USD/MXN", from= startDate, to = endDate, src = "oanda")	#Mexican Peso
getSymbols( "USD/KRW", from= startDate, to = endDate, src = "oanda")	#Korean Won
getSymbols( "USD/IDR", from= startDate, to = endDate, src = "oanda")	#Indonesia?
getSymbols( "USD/INR", from= startDate, to = endDate, src = "oanda")	#India?


DollarToGoldChange 		<- symbolPercentageChange(USDXAU)
DollarToSiverChange		<- symbolPercentageChange(USDXAG)
DollarToEuroChange		<- symbolPercentageChange(USDEUR)
DollarToPoundChange		<- symbolPercentageChange(USDGBP)
DollarToLoonieChange	<- symbolPercentageChange(USDCAD)
DollarToAussieChange	<- symbolPercentageChange(USDAUD)
DollarToYenChange		<- symbolPercentageChange(USDJPY)
DollarToSFrancChange	<- symbolPercentageChange(USDCHF)
DollarToYuanChange		<- symbolPercentageChange(USDCNY)
DollarToRealChange		<- symbolPercentageChange(USDBRL)
DollarToRoubleChange	<- symbolPercentageChange(USDRUB)
DollarToPesoChange		<- symbolPercentageChange(USDMXN)
DollarToWonChange		<- symbolPercentageChange(USDKRW)
DollarToRupiahChange	<- symbolPercentageChange(USDIDR)
DollarToRupeeChange		<- symbolPercentageChange(USDINR)

#
# View the results in a grid for easier viewing
#
View(
	c(
		DollarToGoldChange,
		DollarToSiverChange,
		DollarToEuroChange,
		DollarToPoundChange,
		DollarToLoonieChange,
		DollarToAussieChange,
		DollarToYenChange,
		DollarToSFrancChange,
		DollarToYuanChange,
		DollarToRealChange,
		DollarToRoubleChange,
		DollarToPesoChange,
		DollarToRupiahChange,
		DollarToRupeeChange,
		DollarToWonChange
	)
)

#
# Now we need to add weights to the importance of these percentages - syann
#
# TODO: 2010 stats, this needs to be automated somehow, perhaps FRED - jhaas
#
GLGDP = 61963429	#World GDP

EUGDP <- 16106896	#European Union
USGDP <- 14624184	#United States
CNGDP <- 5745133	#China
JPGDP <- 5390897	#Japan
UKGDP <- 2258565	#Great Britain
BZGDP <- 2023528	#Brazil
CDGDP <- 1563664	#Canada
RSGDP <- 1476912 	#Russia
INGDP <- 1430020 	#India
AUGDP <- 1219722 	#Australia 
MXGDP <- 1004042 	#Mexico
SKGDP <- 986256  	#South Korea
IAGDP <- 695059  	#Indonesia
SZGDP <- 522435  	#Switzerland

GDPbesidesUSA <- EUGDP + CNGDP + JPGDP + UKGDP + BZGDP + CDGDP + RSGDP + 
		INGDP + AUGDP + MXGDP + SKGDP + IAGDP + SZGDP
#GDPbesidesUSA <- GLGDP - USGDP
GDPbesidesUSA

EUweight <- EUGDP / GDPbesidesUSA
CNweight <- CNGDP / GDPbesidesUSA
JPweight <- JPGDP / GDPbesidesUSA
UKweight <- UKGDP / GDPbesidesUSA
BZweight <- BZGDP / GDPbesidesUSA
CDweight <- CDGDP / GDPbesidesUSA
RSweight <- RSGDP / GDPbesidesUSA
INweight <- INGDP / GDPbesidesUSA
AUweight <- AUGDP / GDPbesidesUSA
MXweight <- MXGDP / GDPbesidesUSA
SKweight <- SKGDP / GDPbesidesUSA
IAweight <- IAGDP / GDPbesidesUSA
SZweight <- SZGDP / GDPbesidesUSA

EUweight + CNweight + JPweight + UKweight + BZweight + CDweight + RSweight +
		INweight + AUweight + MXweight + SKweight + IAweight + SZweight

DollarStrengthChange <- 
		(DollarToEuroChange*EUweight)+
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

DollarStrengthChange		

#
# clean up & garbage collect - jhaas
#
#
#rm(
#		endDate, startDate,
#		
#		USDXAU, USDXAG, USDEUR, USDGBP, USDCAD, USDAUD, USDJPY, USDCHF,
#		USDCNY, USDBRL, USDRUB, USDMXN, USDKRW, USDIDR, USDINR,
#		
#		DollarToGoldChange, DollarToSiverChange, DollarToEuroChange,
#		DollarToPoundChange, DollarToLoonieChange, DollarToAussieChange,
#		DollarToYenChange, DollarToSFrancChange, DollarToYuanChange,
#		DollarToRealChange, DollarToRoubleChange, DollarToPesoChange,
#		DollarToRupiahChange, DollarToRupeeChange, DollarToWonChange,
#		
#		USGDP, EUGDP, CNGDP, JPGDP, DEGDP, UKGDP, BZGDP, CDGDP, RSGDP, INGDP, 
#		AUGDP, MXGDP, SKGDP, IAGDP, SZGDP,
#		
#		GDPbesidesUSA,
#		
#		EUweight, CNweight, JPweight, UKweight, BZweight, CDweight,
#		RSweight, INweight, AUweight, MXweight, SKweight, IAweight,
#		SZweight,
#		
#		DollarStrengthChange,
#		
#		symbolPercentageChange
#)
#gcinfo(verbose=TRUE)
#gc(reset=TRUE)
#gcinfo(verbose=FALSE)
