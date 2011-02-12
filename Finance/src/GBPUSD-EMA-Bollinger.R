#install.packages('RJDBC')
#csv.read("gbp/usd", src="oanda", from="2010-01-01", to="2010-05-30")

library("quantmod")
getFX("GBP/USD", from="2010-01-01")
barChart(GBPUSD)
addBBands()
addEMA()

#----------------------------------------------------
# THIS IS FROM Springer's 'Introductory Stats with R'
#----------------------------------------------------

weight = c(60, 72, 57, 90, 95, 72)
height = c(1.75, 1.80, 1.65, 1.90, 1.74, 1.91)
bmi = weight/height^2
# mean, deviation from mean
weight.mean = sum(weight)/length(weight)
weight.stdev = weight - xbar
