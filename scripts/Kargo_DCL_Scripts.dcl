DROP USER IF EXISTS 'admin@buscompany.com'@'%';
CREATE USER 'admin@buscompany.com' IDENTIFIED BY 'Bus.Admin063';
GRANT ALL PRIVILEGES ON bus_management.* TO 'admin@buscompany.com'@'%';

DROP USER IF EXISTS 'fleet@buscompany.com'@'%';
CREATE USER 'fleet@buscompany.com' IDENTIFIED BY 'Fleet.Manager5643';
GRANT ALL PRIVILEGES ON bus_management.bus TO 'fleet@buscompany.com'@'%';

DROP USER IF EXISTS 'routes@buscompany.com'@'%';
CREATE USER 'routes@buscompany.com' IDENTIFIED BY 'Route.Planner195';
GRANT ALL PRIVILEGES ON bus_management.trip TO 'routes@buscompany.com'@'%';
GRANT ALL PRIVILEGES ON bus_management.route TO 'routes@buscompany.com'@'%';

DROP USER IF EXISTS 'finance@buscompany.com'@'%';
CREATE USER 'finance@buscompany.com' IDENTIFIED BY 'Finance.Contract124';
GRANT ALL PRIVILEGES ON bus_management.contract TO 'finance@buscompany.com'@'%';
GRANT ALL PRIVILEGES ON bus_management.firm TO 'finance@buscompany.com'@'%';

SHOW GRANTS FOR 'fleet@buscompany.com'@'%';

REVOKE DELETE ON bus_management.bus FROM 'fleet@buscompany.com'@'%';

DROP USER IF EXISTS 'finance@buscompany.com'@'%';
