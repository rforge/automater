require("TSPostgreSQL")

cat("************** RPostgreSQL  Examples ******************************\n")
cat("**************************************************************\n")
cat("* WARNING: THIS OVERWRITES TABLES IN TEST DATABASE ON SERVER**\n")
cat("**************************************************************\n")

m <- dbDriver("PostgreSQL") # note that this is needed in sourced files.

###### This tests setting up tables. #########

   dbname   <- Sys.getenv("POSTGRES_DATABASE")
   if ("" == dbname)   dbname <- "test"

   user    <- Sys.getenv("POSTGRES_USER")
   host <- Sys.getenv("POSTGRES_HOST")
   if ("" == host) host  <- Sys.getenv("PGHOST")
   if ("" == host) host  <- "localhost"  #Sys.info()["nodename"] 
   if ("" != user) {
       passwd  <- Sys.getenv("POSTGRES_PASSWD")
       if ("" == passwd)   passwd <- NULL
       #  See  ?"dbConnect-methods"
       con <- dbConnect(m, dbname=dbname,
          user=user, password=passwd, host=host)  
     }else  {
	#( the postgres driver may also use PGDATABASE, PGHOST, PGPORT, PGUSER )
       # The Postgress documentation seems to suggest that it should be
       #   possible to get the host from the .pgpass file too, but I cannot.
       #get user/passwd in ~/.pgpass
       con <- dbConnect(m, dbname=dbname, host=host) 
       }

sink("tableLayout.txt.tmp")
dbListTables(con) 
source(system.file("TSsql/CreateTables.TSsql", package = "TSdbi"))
sink(NULL)
dbListTables(con) 
dbDisconnect(con)
dbUnloadDriver(m)
