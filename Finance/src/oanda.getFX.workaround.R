################################################################################
# This script gets around oanda's crappy limit on data download limits.
# This won't handle begin date elegantly: always use Jan 01
################################################################################


config <- list()
config$from <- as.Date('2000-01-01')
config$to   <- Sys.Date()
config$fromYear <- as.integer(format(config$from, '%Y'))
config$toYear <- as.integer(format(config$to, '%Y'))
config$symbol <- 'EUR/USD'
config$symbolfn <- 'EURUSD'


# add the last bit of data needed
eurusd <-
  getSymbols(
    config$symbol,
    src=  'oanda',
    from= paste(config$toYear,'-01-01',sep=''),
    to=   paste(config$to),
    auto.assign=FALSE
  )
#cycle from beginYear to endYear-1 (last year grabbed later)
for ( year in config$fromYear:(config$toYear-1)) {
  print(paste('Getting from year:',year))
  tmp <-
    getSymbols(
      config$symbol,
      src=  'oanda',
      from= paste(year,'-01-01',sep=''),
      to=   paste(year,'-12-31',sep=''),
      auto.assign=FALSE
    )
  eurusd <- c(eurusd,tmp)
}

print("Writing file...")
write.csv(
  eurusd,
  file=paste(
    "c:/my dropbox/",
    config$symbolfn,
    "-1D",
    ".adjclose",
    ".csv",
    sep=''
  ),
  # truncating rownames for encog train data
  row.names=FALSE
)

rm(year,tmp)