CREATE DATABASE simulation_data;
CREATE USER 'simuser'@'%' IDENTIFIED BY 's1mpass';
GRANT ALL PRIVILEGES ON simulation_data.* TO 'simuser'@'%';
FLUSH PRIVILEGES;
