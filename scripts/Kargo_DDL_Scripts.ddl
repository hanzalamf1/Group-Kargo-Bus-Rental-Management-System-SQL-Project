CREATE TABLE firm (
    firm_id INT PRIMARY KEY,
    trust_score DECIMAL(3,2),
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    company_name VARCHAR(100),
    authorized_person VARCHAR(100)
);

CREATE TABLE bus (
    bus_id INT PRIMARY KEY,
    plate VARCHAR(20) UNIQUE,
    brand VARCHAR(50),
    model VARCHAR(50),
    seat_layout VARCHAR(100),
    passenger_capacity INT,
    vehicle_value DECIMAL(10,2),
    average_fuel_consumption DECIMAL(5,2)
);

CREATE TABLE contract (
    contract_id INT PRIMARY KEY,
    bus_id INT,
    firm_id INT,
    monthly_pricing DECIMAL(10,2),
    seat_comission DECIMAL(10,7),
    ticket_comission DECIMAL(10,6),
    km_commission DECIMAL(10,2),
    FOREIGN KEY (bus_id) REFERENCES bus(bus_id) ON DELETE CASCADE,
    FOREIGN KEY (firm_id) REFERENCES firm(firm_id) ON DELETE CASCADE
);


CREATE TABLE trip (
    trip_id INT PRIMARY KEY,
    starting_point VARCHAR(100),
    destination VARCHAR(100),
    distance INT,
    ticket_price DECIMAL(10,2),
    departure_time TIMESTAMP,
    arrival_time TIMESTAMP
);

CREATE TABLE route (
    route_id INT PRIMARY KEY,
    trip_id INT,
    bus_id INT,
    owner_income DECIMAL(20,4),
    total_income DECIMAL(20,4),
    expenses DECIMAL(20,4),
    passenger_count INT,
    FOREIGN KEY (trip_id) REFERENCES trip(trip_id) ON DELETE CASCADE,
    FOREIGN KEY (bus_id) REFERENCES bus(bus_id) ON DELETE CASCADE
);

CREATE TABLE passenger (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    route_id INT,
    passenger_name VARCHAR(100),
    passenger_surname VARCHAR(100),
    FOREIGN KEY (route_id) REFERENCES route(route_id) ON DELETE CASCADE
);
