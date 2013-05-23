# Run this at the level Summary/pac.
# It generates $(PAC).png with the package-version and labels of
# the $(OS_TAGS) that are available.

pkgLabel <- function(){
   wd <- getwd()
   pac <- sub('.*/', '', wd, perl = TRUE) 
   src <- sub(paste0('/Summary/Packages/',pac), '',wd)
  
   #  version
   ver <- scan(paste0(src,'/Packages/',pac,'/',pac,'-version'), nmax=1, what="", quiet=TRUE)
   OSlabels  <-  sub(paste0(src,'/Testing/'), '',
             list.dirs(path=paste0(src,'/Testing'), recursive=FALSE))
   OSlabels  <- OSlabels[ OSlabels != '.svn']

   #dev.new()
   # note that the width, height, and pointsize need to agree with snipGraph
   #png(filename =paste(pac,".png", sep=""), 
   png(filename ="LABEL.png", 
     width=120, height=240, pointsize=12, bg="white")
   par(fig=c(0,1,0,1), mar=c(0,0,4,0))
   plot.new()
   title(paste(pac,ver,sep="\n"))
   os <- length(OSlabels)
   # might get better precision with grid::grid.text() in place of text()
   # dates can be found in snippets details and vary by snippet. Omit from png.
   for (i in 1:os) text(0.5, 1.0 -(i-1)/(os-1), labels=OSlabels[i])
   dev.off()
   invisible()
   }

pkgLabel()
