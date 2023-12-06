# CSCI4370-Final-Project
Run Application: mvn spring-boot:run

Go to http://localhost:8081/

Add page files to src/main/resources/templates using format of *.mustache

Add and populate pages with WebController.java

Create Docker container:
docker run --name finalprojectdb \
-v ~/mysql-data-4370:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=mysqlpass \
-p 8080:3306 \
-d mysql:8.1.0

Enter the Docker instance:
docker exec -it finalprojectdb bash

Create the database and tables:
mysql -h localhost -u root -p -e "source /var/lib/mysql-files/ddl.sql";

Populate tables:
mysql -h localhost -u root -p finalprojectdb < /var/lib/mysql-files/data.sql; 

Group Name: SQL
Pragya Bhayana - Data collection, ER Diagram, Query creation
Navya Bingi - Data Collection, ER Diagram
Jacob Kossler - Data Collection, Schema Implementation, Testing, Demo Video
Elaine Philip - Data Collection, ER Diagram, Query creation
Indigo Powell - Data Collection, ddl.sql, Query creation