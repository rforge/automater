
 require("dse")
 data("eg1.DSE.data.diff", package="dse") 

 if (!is.TSdata(eg1.DSE.data.diff)) stop("Test data not found. Testing stopped.")
 
fuzz.small <- 1e-14
fuzz.large <- 1e-10
digits <- 18
all.ok <- TRUE  


test.rng <- list(kind="Wichmann-Hill",seed=c(979,1479,1542),normal.kind="Box-Muller")

  random.number.test()


 cat("dse test 0 ...\n")
  # check "window"
  z <- tfwindow(outputData(eg1.DSE.data.diff), start=c(1980,1), end=c(1980,1))
  ok <- all( c (c(1,3)==dim(z), c(1980,1)==start(z), c(1980,1)==end(z)))
  z <- tfwindow(outputData(eg1.DSE.data.diff), start=c(1980,1), end=c(1982,12))
  ok <- ok & all( c (c(36,3)==dim(z), c(1980,1)==start(z), c(1982,12)==end(z)))
  all.ok <- ok


 cat("dse test 1 ...\n")
  z <- estVARXls(eg1.DSE.data.diff)
#  z <-eg1.DSE.data.diff
#  lsfit produces warning messages in the following
#  z$output[100,] <-NA
#  z <- estVARXls(z, warn=F)
  VARmodel  <-  estVARXar(eg1.DSE.data.diff, re.add.means=FALSE, warn=FALSE)
  SSmodel  <- toSS(VARmodel)
  ok <- fuzz.large > abs(VARmodel$estimates$like[1] -
               l(SSmodel, eg1.DSE.data.diff, warn=FALSE)$estimates$like[1])
  ok <- ok & is.TSestModel(VARmodel) & is.TSmodel(VARmodel$model)
  ok <- ok & (nseriesInput(VARmodel) == nseriesInput(SSmodel))
  ok <- ok & (nseriesInput(VARmodel) == nseriesInput(VARmodel$data))
  ok <- ok & (nseriesOutput(VARmodel) == nseriesOutput(SSmodel))
  ok <- ok & (nseriesOutput(VARmodel) == nseriesOutput(VARmodel$data))
  VARmodelB <- TSmodel(VARmodel)
  B <- t(chol(VARmodel$estimates$cov))
  VARmodelB$B <- array(B, c(1,dim(B)))  # has B != I
  VARmodelB <- setTSmodelParameters(VARmodelB)
  VARmodelB <- l(VARmodelB,VARmodel$data, warn=FALSE)

  z <- residuals(VARmodelB)
  z <- acf(VARmodelB)
  #x11()
  #get(getOption("device"))()
  dev.new()
  acf(VARmodelB)

   good <- VARmodel$estimates$pred
   tst  <- VARmodelB$estimates$pred
   error <- max(abs(good-tst))
   cat("max. error ", max(error))

   if (any(is.na(error)) || any(is.nan(error)) || fuzz.large < error) 
     {printTestValue(c(tst), digits=18)
      all.ok <- FALSE  
     }

  if (! all.ok) stop("some tests FAILED")

