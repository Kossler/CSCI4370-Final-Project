# CSCI4370-Final-Project
Group Name: SQL
Pragya Bhayana - Data collection, ER Diagram, prelim.pdf, Query creation
Navya Bingi - Data Collection, ER Diagram, prelim.pdf, Query Creation
Jacob Kossler - Data Collection, prelim.pdf, security.txt, Schema Implementation, Testing, Demo Video
Elaine Philip - Data Collection, ER Diagram prelim.pdf, Query creation
Indigo Powell - Data Collection, ER Diagram, prelim.pdf, db_design.pdf, ddl.sql

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

Demo Users:
jacob.kossler@gmail.com
password

brock.bowers@gmail.com
password

kirby.smart@gmail.com
password

Technologies:
Java
Mustache
BCrypt
Python
Pandas
MySQL
HTML
JavaScript
Maven
