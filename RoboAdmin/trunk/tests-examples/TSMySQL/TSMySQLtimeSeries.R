require("TSMySQL")

cat("************** RMySQL  Examples ******************************\n")
cat("**************************************************************\n")
cat("* WARNING: THIS OVERWRITES TABLES IN TEST DATABASE ON SERVER**\n")
cat("**************************************************************\n")

m <- dbDriver("MySQL") # note that this is needed in sourced files.

###### This is to set up tables. Otherwise use TSconnect#########
   dbname   <- Sys.getenv("MYSQL_DATABASE")
   if ("" == dbname)   dbname <- "test"

   user    <- Sys.getenv("MYSQL_USER")
   if ("" != user) {
       # specifying host as NULL or "localhost" results in a socket connection
       host    <- Sys.getenv("MYSQL_HOST")
       if ("" == host)     host <- Sys.info()["nodename"] 
       passwd  <- Sys.getenv("MYSQL_PASSWD")
       if ("" == passwd)   passwd <- NULL
       #  See  ?"dbConnect-methods"
       con <- dbConnect("MySQL",
          username=user, password=passwd, host=host, dbname=dbname)  
     }else  con <- 
       dbConnect(m, dbname=dbname) # pass user/passwd/host in ~/.my.cnf

# sink here because printout from commands in source depends somewhat on
#  the server character set
sink("tableLayout.txt.tmp")
source(system.file("TSsql/CreateTables.TSsql", package = "TSdbi"))
sink(NULL)
dbListTables(con) 
dbDisconnect(con)
##################################################################

con <- if ("" != user) tryCatch(TSconnect(m, dbname=dbname, 
	  username=user, password=passwd, host=host)) else  
    tryCatch(TSconnect(m, dbname=dbname)) # pass user/passwd/host in ~/.my.cnf

if(inherits(con, "try-error")) stop("CreateTables did not work.")

source(system.file("TSsql/Populate.TSsql", package = "TSdbi"))
source(system.file("TSsql/TSdbi.TSsql", package = "TSdbi"))
sink("tableLayout.txt.tmp", append=TRUE)
source(system.file("TSsql/dbGetQuery.TSsql", package = "TSdbi"))
# sink next because series end is printed (and changes)
source(system.file("TSsql/HistQuote.TSsql", package = "TSdbi"))
sink(NULL)

cat("**************        disconnecting test\n")
dbDisconnect(con)
dbUnloadDriver(m)



cat("***** RMySQL  with timeSeries representation *********\n")

require("TSMySQL")
require("timeSeries")

dbname   <- Sys.getenv("MYSQL_DATABASE")
if ("" == dbname)   dbname <- "test"

user	<- Sys.getenv("MYSQL_USER")

# specifying host as NULL or "localhost" results in a socket connection
host	<- Sys.getenv("MYSQL_HOST")
if ("" == host)     host <- Sys.info()["nodename"] 
passwd  <- Sys.getenv("MYSQL_PASSWD")
if ("" == passwd)   passwd <- NULL

con <- if ("" != user) tryCatch(TSconnect("MySQL", dbname=dbname,
          username=user, password=passwd, host=host)) else  
    tryCatch(TSconnect("MySQL", dbname=dbname)) # pass user/passwd/host in ~/.my.cnf

if(inherits(con, "try-error")) stop("Cannot connect to TS MySQL database.")

  z <- TSget("Series 1", con, TSrepresentation="timeSeries")
  if("timeSeries" != class(z)) stop("timeSeries class object not returned.")
  tfplot(z)

  options(TSrepresentation="timeSeries")

  z <- TSget(c("matc1","matc2"), con)
  if("timeSeries" != class(z)) stop("timeSeries class object not returned.")
  tfplot(z)
 
  TSrefperiod(z) 
  TSdescription(z) 

  tfplot(z, start="1991-01-01", Title="Test")

cat("**************        disconnecting test\n")
dbDisconnect(con)