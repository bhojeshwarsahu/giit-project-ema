/* uncomment when use vm
CREATE USER 'root'@'localhost or private_IP_of_VM' IDENTIFIED BY'some-pass';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'ip_address';*/
CREATE TABLE IF NOT EXISTS `EMPLOYEES` (
   emp_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
   emp_name varchar(255) NOT NULL,
   emp_contact varchar(10),
   emp_add varchar(255) DEFAULT false
   ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
