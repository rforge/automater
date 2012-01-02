require("TSPostgreSQL")

cat("************** RPostgreSQL  Examples ******************************\n")
cat("**************************************************************\n")
cat("* WARNING: THIS OVERWRITES TABLES IN TEST DATABASE ON SERVER**\n")
cat("**************************************************************\n")

m <- dbDriver("PostgreSQL") # note that this is needed in sourced files.

###### This is to set up tables. Otherwise use TSconnect#########

con <- dbConnect(m, dbname="test", 
     user     = Sys.getenv("POSTGRES_USER"), 
     password = Sys.getenv("POSTGRES_PASSWD"), 
     host     = Sys.getenv("POSTGRES_HOST"))  

sink("tableLayout.txt.tmp")
dbListTables(con) 
source(system.file("TSsql/CreateTables.TSsql", package = "TSdbi"))
sink(NULL)
dbListTables(con) 
dbDisconnect(con)

con <- tryCatch(TSconnect(m, dbname="test",
     user     = Sys.getenv("POSTGRES_USER"), 
     password = Sys.getenv("POSTGRES_PASSWD"), 
     host     = Sys.getenv("POSTGRES_HOST")))
    
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
