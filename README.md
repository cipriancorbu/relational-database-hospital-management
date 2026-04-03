 # Hospital Management Database System

## Overview

This project is a relational database system designed for managing hospital operations, including patients, doctors, appointments, admissions, treatments and billing.

The system is built using SQL (PostgreSQL) and demonstrates database design, data modelling and backend logic implementation.

---

## Features

* Fully normalised relational database (3NF)
* CRUD operations (Create, Read, Update, Delete)
* Data integrity using primary keys, foreign keys and constraints
* Indexed queries for improved performance
* Views for simplified data access
* Stored procedures for business logic
* Triggers for automated updates (e.g. room availability)

---

## Database Structure

Main entities include:

* Patient
* Doctor
* Nurse
* Room
* Appointment
* Admission
* Treatment
* Bill

The system models real-world relationships between these entities.

---

## Example Functionality

* Book appointments between patients and doctors
* Manage hospital admissions and room allocation
* Track treatments and billing
* Automatically update room availability using triggers
* Retrieve structured data using SQL queries and views

---

## Technologies Used

* PostgreSQL
* SQL (DDL, DML, DCL concepts)
* Database Design (ER modelling, normalization)

---

## How to Run

1. Execute `Create_table.sql` to create all tables
2. Run CRUD scripts to populate and manipulate data:

   * Create scripts
   * Read queries
   * Update scripts
   * Delete scripts
3. Test queries in PostgreSQL environment

---

## Project Structure

* SQL scripts for schema and CRUD operations
* Database diagram
* Project report (design justification)

---

## Key Learning Outcomes

* Relational database design and normalization
* Query optimisation and indexing
* Implementing business logic using triggers and procedures
* Working with real-world data models

---

## Author

Ciprian-Constantin Corbu
