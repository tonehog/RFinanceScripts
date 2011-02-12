# TODO: This is for plinking around on, a lot of good examples here
# 
# Author: tonehog
###############################################################################
library('quantmod')
library('TTR')
library('lattice')

startdate = '2009-01-01::'

#get data
getSymbols('^XAU')
XAU <- XAU[startdate]

getSymbols('^DJI')
DJI <- DJI[startdate]

#access a column / set of columns
XAU[,'XAU.Open']
XAU[,c('XAU.Open','XAU.High', 'XAU.Close')]

#zoo-ify them for math
xauzoo <- zoo(XAU)
djizoo <- zoo(DJI)

#extract BBands from symbol
XAU$BBands <- BBands()
View(XAU$BBands)

#extract with OHLC tools
foo <- Op(XAU)
View(foo)
foo <- BBands(HLC(XAU))
View(foo)

#dji versus xau by division, convert zoo's back to xts
djivsxau <- Reclass((djizoo/xauzoo))

#lattice()
#layout(1:2)
chartSeries(
	djivsxau,
	name='Dow Jones Industrial Index',
	theme='black',
	TA='addCCI(n=96)'
)
#plot(DJI$Open, name="Dow Jones Industrial Index vs. Price of Gold in USD")