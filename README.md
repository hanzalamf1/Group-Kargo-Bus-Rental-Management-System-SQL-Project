# 🚍 Kargo Bus Rental Management System
---
## ER Diagram
---
## 📁 File Paths

### 📜 Scripts Directory (`scripts/`)
- `Kargo_DML_Scrpits.dml`
- `Kargo_DDL_Scripts.ddl`
- `Kargo_DCL_Scripts.dcl`
- `Kargo_DQL_Scripts.dql`
- `Kargo_bus_rental_system_SQL.sql`

### 📄 Documents Directory (`documents/`)
- `ER-Diagram.pdf`
- `Kargo_DeploymentPlanDocument.pdf`
- `Kargo_RequirementDocument.pdf`
- `Kargo_SystemDesignDocument.pdf`

---

## 🤝 Contributors

| Name                   | GitHub Username | Contribution                                     |
|------------------------|-----------------|--------------------------------------------------|
| Damla Karpus           | DamlaKarpus     | ER Diagram and Requirement Document              |
| Ezgi Komurcu           | ezgikomurcu     | System Design Document and Use Case Design       |
| Ahmet Şamil Kırkgöz    | (no GitHub yet) | Deployment Plan Document and MySQL Installation  |
| Muhammed Hanzala Akbaş | hanzalamf1      | All SQL Scripts and Query Writing                |

---

## 🗂️ Table of Contents
- 🌟 [Project Summary](#-project-summary)
- 🗃️ [Database Schema](#-database-schema)
- 🛠️ [System Features](#-system-features)
- ⚙️ [Installation](#-installation)
- 🔍 [Query Details](#-query-details)
- ➗ [Mathematical Model](#-mathematical-model)
- 📈 [Performance Metrics](#-performance-metrics)
- 📂 [Sample Dataset](#-sample-dataset)
- 🤝 [Contribution](#-contribution)
- 📜 [License](#-license)

---

## 🌟 Project Summary

This project is a comprehensive database management system tailored for the **cargo bus rental industry**, including:

- Fleet Management: Bus inventory tracking and maintenance records  
- Contract Management: Dynamic rental contracts and commission calculations  
- Trip Planning: Route optimization and time management  
- Financial Analysis: Real-time profit and loss calculations  
- Passenger Management: Ticketing and passenger tracking system  

---

## 🗃️ Database Schema

### 📊 Table Structures

#### `firm` Table
| Column           | Data Type     | Description                     |
|------------------|---------------|---------------------------------|
| firm_id          | INT           | Primary key                     |
| trust_score      | DECIMAL(3,2)  | Company trust score (1–10)      |
| phone            | VARCHAR(15)   | Contact phone number            |
| email            | VARCHAR(100)  | Email address (unique)          |
| company_name     | VARCHAR(100)  | Company name                    |
| authorized_person| VARCHAR(100)  | Authorized person               |

#### `bus` Table
| Column                | Data Type      | Description                            |
|------------------------|----------------|----------------------------------------|
| bus_id                | INT            | Primary key                            |
| plate                 | VARCHAR(20)    | License plate (unique)                 |
| brand                 | VARCHAR(50)    | Brand                                  |
| model                 | VARCHAR(50)    | Model information                      |
| seat_layout           | VARCHAR(100)   | Seat configuration (e.g., 2+1, 2+2)    |
| passenger_capacity    | INT            | Passenger capacity                     |
| vehicle_value         | DECIMAL(10,2)  | Vehicle value (in TL)                  |
| average_fuel_consumption | DECIMAL(5,2) | Average fuel per 100 km (liters)      |

#### `contract` Table
| Column           | Data Type     | Description                          |
|------------------|---------------|--------------------------------------|
| contract_id      | INT           | Primary key                          |
| bus_id           | INT           | Bus ID (foreign key)                 |
| firm_id          | INT           | Firm ID (foreign key)                |
| monthly_pricing  | DECIMAL(10,2) | Monthly rental fee                   |
| seat_comission   | DECIMAL(10,7) | Commission per seat                  |
| ticket_comission | DECIMAL(10,6) | Commission per ticket                |
| km_commission    | DECIMAL(10,2) | Commission per kilometer             |

#### `trip` Table
| Column         | Data Type     | Description               |
|----------------|---------------|---------------------------|
| trip_id        | INT           | Primary key               |
| starting_point | VARCHAR(100)  | Departure location        |
| destination    | VARCHAR(100)  | Arrival location          |
| distance       | INT           | Distance (km)             |
| ticket_price   | DECIMAL(10,2) | Ticket price              |
| departure_time | TIMESTAMP     | Departure time            |
| arrival_time   | TIMESTAMP     | Arrival time              |

#### `route` Table
| Column         | Data Type       | Description             |
|----------------|-----------------|-------------------------|
| route_id       | INT             | Primary key             |
| trip_id        | INT             | Trip ID (foreign key)   |
| bus_id         | INT             | Bus ID (foreign key)    |
| owner_income   | DECIMAL(20,4)   | System owner income     |
| total_income   | DECIMAL(20,4)   | Total income            |
| expenses       | DECIMAL(20,4)   | Total expenses          |
| passenger_count| INT             | Number of passengers    |

#### `passenger` Table
| Column            | Data Type     | Description                   |
|-------------------|---------------|-------------------------------|
| passenger_id      | INT           | Primary key (auto increment)  |
| route_id          | INT           | Route ID (foreign key)        |
| passenger_name    | VARCHAR(100)  | Passenger first name          |
| passenger_surname | VARCHAR(100)  | Passenger last name           |

---

## 🛠️ System Features

### 📌 Core Functions
- Bus Tracking System  
- Dynamic Contract Management  
- Real-Time Reporting  
- Passenger Management  

### 🔒 User Roles
| Role           | Access Level            |
|----------------|--------------------------|
| Admin          | Full system access       |
| Fleet Manager  | Bus record management    |
| Route Planner  | Trip and route management|
| Financial Officer | Contract & payment tracking |

---

## ⚙️ Installation

### Requirements:
- MySQL 8.0+
- 2 GB RAM (min)
- 500 MB disk space

### Installation Steps:
```bash
mysql -u root -p < Kargo_bus_rental_system_SQL.sql


# 🧪 Test Data & 📊 Query Details

---

## 🧾 Test Data

```sql
SELECT COUNT(*) FROM firm;  -- 20 test firms
SELECT COUNT(*) FROM bus;   -- 20 test buses
```

---

## 🔍 Query Details

### 1. 💰 Financial Analysis Query

```sql
SELECT 
    r.route_id,
    f.company_name,
    ROUND(r.total_income, 2) AS total_income,
    ROUND(r.expenses, 2) AS expenses,
    ROUND(r.owner_income, 2) AS owner_income,
    ROUND(r.total_income - r.expenses - r.owner_income, 2) AS firm_profit
FROM route r
JOIN bus b ON r.bus_id = b.bus_id
JOIN contract c ON b.bus_id = c.bus_id
JOIN firm f ON c.firm_id = f.firm_id;
```

---

### 2. 🏆 Top Profitable Routes

```sql
SELECT 
    route_id,
    starting_point,
    destination,
    owner_income
FROM route
JOIN trip ON route.trip_id = trip.trip_id
ORDER BY owner_income DESC
LIMIT 5;
```

---

### 3. 📈 Occupancy Rate Analysis

```sql
SELECT 
    bus_id,
    AVG(passenger_count) AS avg_passengers,
    MAX(passenger_capacity) AS capacity,
    ROUND(AVG(passenger_count) / MAX(passenger_capacity) * 100) AS fill_rate
FROM route
JOIN bus ON route.bus_id = bus.bus_id
GROUP BY bus_id;
```

---

## ➗ Mathematical Model

### 🔢 Core Formulas

**Daily Rental Cost**
```ini
daily_rent = monthly_pricing / 30
```

**Fuel Cost**
```ini
fuel_cost = (distance * average_fuel_consumption / 100) * fuel_price
```

**Total Commission**
```makefile
total_commission = 
    (passenger_count * ticket_price * ticket_comission) +
    (bus_capacity * ticket_price * seat_comission) +
    (distance * km_commission / 100)
```

**Profit Margin**
```ini
profit_margin = (total_income - total_cost) / total_income * 100
```

---

## 🧮 Sample Calculation

| **Parameter**         | **Value**        |
|-----------------------|------------------|
| Monthly Rent          | 10,800 TL        |
| Ticket Price          | 1,050 TL         |
| Passenger Count       | 45               |
| Distance              | 450 km           |
| Fuel Consumption      | 30.5 L/100 km    |
| Fuel Price            | 50 TL/L          |

**Calculations:**

- **Daily Rent:** `10,800 / 30 = 360 TL`  
- **Fuel Cost:** `(450 * 30.5 / 100) * 50 = 6,862.5 TL`  
- **Total Expenses:** `6,862.5 + 3,000 (fixed) = 9,862.5 TL`  
- **Total Income:** `45 * 1,050 = 47,250 TL`  
- **Profit:** `47,250 - 9,862.5 = 37,387.5 TL`

---

## 📈 Performance Metrics

### 📌 Key Indicators

| **Metric**             | **Formula**                                     | **Description**             |
|------------------------|--------------------------------------------------|-----------------------------|
| ROI                    | (Net Profit / Investment) × 100                 | Return on investment        |
| Occupancy Rate         | (Passenger Count / Capacity) × 100              | Bus load efficiency         |
| Cost per km            | Total Expenses / Total Km                       | Operational efficiency      |
| Profit per Passenger   | Net Profit / Passenger Count                    | Profit per rider            |

---

### 📋 Sample Table

| **Company**   | **ROI** | **Occupancy Rate** |
|---------------|---------|--------------------|
| Kamil Koç     | 85%     | 92%                |
| Metro         | 78%     | 88%                |
| Pamukkale     | 82%     | 91%                |

---

## 📂 Sample Dataset Overview

### 📊 Basic Statistics

- **Total Companies:** 20  
- **Total Buses:** 20  
- **Total Trips:** 30  
- **Total Routes:** 20  
- **Total Passengers:** 723  

---

## 📜 License

MIT License - Distributed as open source software.
