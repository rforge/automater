# Run this at the Summary/  level.
# It generates header.png with the R-version colour indications

headerLabel <- function(){
   ver <- scan("../Testing/R-version", nlines=1, what="",sep="\n", quiet=TRUE)

   #dev.new()
   # note that the width, height, and pointsize need to agree with snipGraph
   #png(filename =paste(pkg,".png", sep=""), 
   png(filename ="HEADER.png", 
     width=960, height=120, pointsize=12, bg="white")
   par(fig=c(0,1,0,1), mar=c(0,0,4,0))
   plot.new()
   # might get better precision with grid::grid.text() for this
   #title(ver)
   y <- 0.6
   text(0.5, 0.9 , labels=paste('testing', ver, 
     '. If snippet details indicate an older R then tests with this version have not yet been run.'))
   
   segments(x0=0.0, x1=0.02, y0=y, col="red", lwd=10)
   text(0.1, y, labels="tests fail or no tests;")
   
   segments(x0=0.19, x1=0.21, y0=y, col="orange", lwd=10)
   text(0.30, y, labels="tests fail, recognized bug;")
   
   segments(x0=0.4, x1=0.42, y0=y, col="blue", lwd=10)
   text(0.51, y, labels="tests fail, feature request;")
   
   segments(x0=0.61, x1=0.63, y0=y, col="green", lwd=10)
   text(0.68, y, labels="tests pass;")
   
   segments(x0=0.76, x1=0.78, y0=y, col="black", lwd=10)
   text(0.9, y, labels="no server with resources to test.")
   dev.off()
   invisible()
   }

headerLabel()
