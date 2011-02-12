###############################################################################
# SPR500 with correction to value of dollar based on gold spot
###############################################################################

library("quantmod")


# Get SPY AND ^DJIA from Google
getSymbols(
		c('SPY', '^DJI'),
		from	= Sys.Date() - 499,
		to		= Sys.Date(),
		src		= "google"
)

# Get EURUSD from Google
getSymbols(
		c('GBP/USD', 'EUR/USD'),
		from	= Sys.Date() - 499,
		to 		= Sys.Date(),
		src		= "oanda"
)

# Get USO (also: OIL or WTI) (WTI is too variant)
getSymbols(
		c('USO', 'OIL'),
		from	= Sys.Date() - 499,
		to		= Sys.Date(),
		src		= 'yahoo'
)

getSymbols(
		c('MULT'),
		from	= Sys.Date() - 499,
		to		= Sys.Date(),
		src		= 'FRED'
)


###############################################################################
# Calculations
###############################################################################

DJIxMULT <- DJI * MULT

###############################################################################
# Charting
###############################################################################

chartSeries(DJIxMULT)
#layout(1:6)

#chartSeries(
#		c(
#			OIL,
#			USO,
#			GBPUSD,
#			EURUSD,
#			SPY,
#			DJIA
#		)
#)
