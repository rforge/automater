
# Run this at the level Summary/pac/snip . It uses all  Testing/OS_TYPES.
# It generates files $(SNIP).png with the bar graphs of the summarized
# results for each snippet.

assessSnip <- function(){
  wd <- getwd()
  snippet <- sub('.*/', '', wd) 
  pac <- sub('.*/', '', sub(paste0('/',snippet), '',wd))
  src <- sub(paste0('/Summary/Packages/',pac,'/',snippet), '',wd)
  
  #list.files(pattern="TESTABLE", recursive = TRUE)))
  OSlabels  <-  sub(paste0(src,'/Testing/'), '',
             list.dirs(path=paste0(src,'/Testing'), recursive=FALSE))
  OSlabels  <- OSlabels[ OSlabels != '.svn']

  # number of tests can be determined from passfail, but fails if 
  #   the first OS is not testable. This gets .r or .R but skips "data.motor" in one pac
  N <- length(list.files(path=paste0(src,'/Packages/',pac,'/',snippet), pattern= ".*\\.[Rr]$"))
  os <- length(OSlabels)

  # maintainerCat is for each *.R file the package maintainers classification
  # NA, bug, featureRequest:  NA, 0, 1
  # if the file is missing, NA is assumed for all tests
  z <-paste0(src,'/Packages/',pac,'/',snippet, '/MAINTAINER.categorization')
  if (!file.exists(z)) {
     maintainerCat <- rep(NA, N)
     mNames <- NULL
     }
  else{
     z <- scan(z, list("",""), quiet=TRUE)
     maintainerCat <- as.numeric(z[[2]])
     mNames <- z[[1]]
     names(maintainerCat) <- mNames
     }

  if(length(maintainerCat) != N)
    stop("maintainerCat needs to be same length as number of tests.")

  #testable is for each OS label, one indication for the whole snippet of
  #whether there is a farm server with the resources to run it.

  testable  <- rep(NA, os)
  passfail  <- matrix(NA, N,os)
  for (i in 1:os) {
     z <- paste0(src,'/Testing/',OSlabels[i],'/',pac,'/',snippet)
     testable[i] <-  "UNKNOWN" != scan(paste0(z,'/TESTABLE'), what="", quiet=TRUE)[1]
     if(testable[i]) {
        z <- scan(paste0(z, "/STATUS_SUMMARY"), what=list("",""), skip=1, quiet=TRUE)
	nm <- z[[1]]
	z <- z[[2]]
        if (0 == length(z)) {
	   warning("STATUS_SUMMARY file for OS ",OSlabels[i], " does not have results.")
	   z <- rep(NA,N)
	   nm <- mNames #not really, but value will not matter
	   }
	#passfail needs to be in tha same order as maintainerCat, if that exists
	if (!is.null(mNames)) {
	   nm <- sub("-STATUS:", "", nm)
	   names(z) <- nm
	   passfail[,i] <- "passed." == z[mNames]
	   }
	else passfail[,i] <- "passed." == z
        }

     }
  
  snipGraph(snippet, passfail, maintainerCat, testable=testable)
  }

snipGraph <- function(snippet, passfail, maintainerCat, testable){
   n  <- NROW(passfail)
   os <- NCOL(passfail)
   # dev.new()
   # note that the width, height, and pointsize need to agree with pkgLabel
   #png(filename =paste(snippet,".png", sep=""), 
   png(filename ="SUMMARY.png", 
     width=120, height=240, pointsize=12, bg="white")
   par(fig=c(0,1,0,1), mar=c(0,0,4,0))
   plot.new()
   title(snippet)
   for (i in 1:os) {
     y <- 1.0 -(i-1)/(os-1)
     if (!testable[i] || (n > 0 & all(is.na(passfail[,i])))){ 
       # not testable or not tested
       segments(x0=0,	 x1=1,    y0=y, col="black",	lwd=10)
       }
     else if (0==n){
       # 0==n  No tests in snippet, eg Selftest
       segments(x0=0,	 x1=1,    y0=y, col="red",    lwd=10)
       text(0.9, y, labels=paste(0,"/",n, sep=""))
      }
     else{
       okn <- sum(passfail[,i]) 
       ok <- okn / n
       # fail: r(red)=not categorized, o(orange)=bug  b(blue)=feature request
       f <- !passfail[,i]
       r <- sum( f &	is.na(maintainerCat)) / n
       o <- sum((f & !maintainerCat)[!is.na(maintainerCat)]) / n
       b <- sum((f &  maintainerCat)[!is.na(maintainerCat)]) / n
       # fuzz for rounding error 
       if (1e-13 <  abs((1-ok) - (r+o+b)) ) stop("bad computation.")
       if (1e-13 <  abs(r))   segments(x0=0,	 x1=r,    y0=y, col="red",    lwd=10)
       if (1e-13 <  abs(o))   segments(x0=r,	 x1=r+o,  y0=y, col="orange", lwd=10)
       if (1e-13 <  abs(b))   segments(x0=r+o,  x1=1-ok, y0=y, col="blue",   lwd=10)
       if (1e-13 <  abs(ok)) segments(x0=1-ok, x1=1,    y0=y, col="green",  lwd=10)
       text(0.9, y, labels=paste(okn,"/",n, sep=""))
       }
     }
   dev.off()
   invisible(snippet)
   }

assessSnip()
