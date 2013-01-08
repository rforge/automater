#    write to xls file

require("tframePlus")

# consider  BankLending in place of shortBC
 z <- cbind(1:100, matrix(rnorm(300),100,3)) 

# names get used in Excel labels 
seriesNames(z) <- c("index", "series 1", "series 2", "series 3")


ok <- TSwriteXLS(z, FileName="testOut.xls",dateHeader="Last obs: 100")

if(!ok) stop("writing xls file failed.")
