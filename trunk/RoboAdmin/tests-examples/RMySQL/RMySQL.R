require("RMySQL")

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

sink("tableLayout.txt.tmp")
dbListTables(con) 
source(system.file("TSsql/CreateTables.TSsql", package = "TSdbi"))
sink(NULL)
dbListTables(con) 
dbDisconnect(con)
dbUnloadDriver(m)

