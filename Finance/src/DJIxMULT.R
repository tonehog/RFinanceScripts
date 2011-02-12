# TODO: DJI weighted against dollar multiplier (MULT)
# 
# Author: tonehog
###############################################################################

library("quantmod")

Range		<- vector()
Range$Start	<- '2001-01-01'
Range$End	<- '2011-01-01' #Sys.Date() #that's today


# Get DJIA, SPY, and USD Multiplier (MULT)
getSymbols(
		c('SPY', '^DJI'),
		from	= Range$Start,
		to		= Range$End,
		src		= 'yahoo'
)

getSymbols(
		c('MULT'),
		from	= Range$Start,
		to		= Range$End,
		src		= 'FRED'
)


###############################################################################
# Calculations
###############################################################################

DJIxMULT <- reclass(DJI$DJI.Adjusted * MULT$MULT)


###############################################################################
# Charting
###############################################################################

plot(
	DJIxMULT,
	col="red",
	main="",
	xlab=""
)
par( new=T )
plot(
	DJI,
	col="blue",
	main="DJI (Adjusted) and DJI (Adjusted) * MULT)"
)

#layout(1:6)

rm(
		DJI,
		DJIxMULT,
		MULT,
		SPY,
		Range
)
gc()