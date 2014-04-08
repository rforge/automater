require("TSPostgreSQL")

cat("************** RPostgreSQL  Examples ******************************\n")
cat("**************************************************************\n")
cat("* WARNING: THIS OVERWRITES TABLES IN TEST DATABASE ON SERVER**\n")
cat("**************************************************************\n")

m <- dbDriver("PostgreSQL") # note that this is needed in sourced files.

###### This is to set up tables. Otherwise use TSconnect#########

conInit <- dbConnect(m, dbname="test", 
     user     = Sys.getenv("POSTGRES_USER"), 
     password = Sys.getenv("POSTGRES_PASSWD"), 
     host     = Sys.getenv("POSTGRES_HOST"))  

sink("tableLayout.txt.tmp")
dbListTables(conInit) 
#source(system.file("TSsql/CreateTables.TSsql", package = "TSdbi"))
require("TSsql")
removeTSdbTables(conInit, yesIknowWhatIamDoing=TRUE)
createTSdbTables(conInit, index=FALSE)
sink(NULL)
dbListTables(conInit) 
dbDisconnect(conInit)

con <- tryCatch(TSconnect(m, dbname="test",
     user     = Sys.getenv("POSTGRES_USER"), 
     password = Sys.getenv("POSTGRES_PASSWD"), 
     host     = Sys.getenv("POSTGRES_HOST")))
    
if(inherits(con, "try-error")) stop("CreateTables did not work.")

source(system.file("TSsql/Populate.TSsql", package = "TSsql"))
source(system.file("TSsql/TSdbi.TSsql", package = "TSsql"))
sink("tableLayout.txt.tmp", append=TRUE)
source(system.file("TSsql/dbGetQuery.TSsql", package = "TSsql"))
# sink next because series end is printed (and changes)
source(system.file("TSsql/HistQuote.TSsql", package = "TSsql"))
sink(NULL)

cat("**************        disconnecting test\n")
dbDisconnect(con)
dbUnloadDriver(m)
