# Run this at the package level.
# It generates $(PKG).png with the package-version and labels of
# the $(OS_TAGS) that are available.

pkgLabel <- function(){
   pkg <- sub('.*/', '', getwd(), perl = TRUE) 
   ver <- scan(paste(pkg,"-version", sep=""), nmax=1, what="")
   labels  <-  unique(sub('.*/', '', sub("TESTABLE-","",
       list.files(pattern="TESTABLE-*", recursive = TRUE))))

   #dev.new()
   # note that the width, height, and pointsize need to agree with snipGraph
   #png(filename =paste(pkg,".png", sep=""), 
   png(filename ="LABEL.png", 
     width=120, height=240, pointsize=12, bg="white")
   par(fig=c(0,1,0,1), mar=c(0,0,4,0))
   plot.new()
   title(paste(pkg,ver,sep="\n"))
   os <- length(labels)
   # might get better precision with grid::grid.text() for this
   for (i in 1:os){
     text(0.5, 1.0 -(i-1)/(os-1), labels=labels[i])
     }
   dev.off()
   invisible()
   }

pkgLabel()
