docker run -it
--name sqlserver --hostname sqlserver
-p 1433:1433  
-e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=0823" 
-d mcr.microsoft.com/mssql/server:2019-latest
