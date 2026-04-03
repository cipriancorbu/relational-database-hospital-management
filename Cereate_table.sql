
-- ========================================
-- Patient Table
-- ========================================
-- This table stores all personal information about patients.

CREATE TABLE Patient (
    patient_id SERIAL PRIMARY KEY,  -- Unique identifier for each patient
    first_name VARCHAR(100) NOT NULL,  -- Patient's first name
    last_name VARCHAR(100) NOT NULL,  -- Patient's last name
    dob DATE NOT NULL,  -- Date of birth
    phone_number VARCHAR(15) NOT NULL UNIQUE,  -- Patient's phone number (unique)
    email VARCHAR(100) NOT NULL UNIQUE,  -- Patient's email address (unique)
    address VARCHAR(255),  -- Patient's home address
    gender VARCHAR(10),  -- Gender of the patient (Male/Female/Other)
    emergency_contact VARCHAR(15)  -- Emergency contact phone number
);

-- Sample Insertion into Patient Table
INSERT INTO Patient (first_name, last_name, dob, phone_number, email, address, gender, emergency_contact)
VALUES
    ('John', 'Doe', '1985-04-10', '1234567890', 'john.doe@example.com', '123 Elm St', 'Male', '9876543210'),
    ('Jane', 'Smith', '1990-06-25', '1234567891', 'jane.smith@example.com', '456 Oak St', 'Female', '9876543211');

-- ========================================
-- Doctor Table
-- ========================================
-- This table stores information about doctors in the hospital.

CREATE TABLE Doctor (
    doctor_id SERIAL PRIMARY KEY,  -- Unique identifier for each doctor
    first_name VARCHAR(100) NOT NULL,  -- Doctor's first name
    last_name VARCHAR(100) NOT NULL,  -- Doctor's last name
    specialisation VARCHAR(100) NOT NULL,  -- Area of expertise (e.g., Cardiology, Neurology)
    phone_number VARCHAR(15) NOT NULL UNIQUE,  -- Doctor's contact number (unique)
    email VARCHAR(100) NOT NULL UNIQUE  -- Doctor's email address (unique)
);

-- Sample Insertion into Doctor Table
INSERT INTO Doctor (first_name, last_name, specialisation, phone_number, email)
VALUES
    ('Dr. Alice', 'Brown', 'Cardiology', '1234567892', 'alice.brown@example.com'),
    ('Dr. Bob', 'Green', 'Neurology', '1234567893', 'bob.green@example.com');

-- ========================================
-- Nurse Table
-- ========================================
-- This table holds information about nurses.

CREATE TABLE Nurse (
    nurse_id SERIAL PRIMARY KEY,  -- Unique identifier for each nurse
    first_name VARCHAR(100) NOT NULL,  -- Nurse's first name
    last_name VARCHAR(100) NOT NULL,  -- Nurse's last name
    shift_time VARCHAR(50) NOT NULL,  -- Time of shift (e.g., Morning, Evening)
    phone_number VARCHAR(15) NOT NULL UNIQUE,  -- Nurse's contact number (unique)
    email VARCHAR(100) NOT NULL UNIQUE  -- Nurse's email address (unique)
);

-- Sample Insertion into Nurse Table
INSERT INTO Nurse (first_name, last_name, shift_time, phone_number, email)
VALUES
    ('Emma', 'Williams', 'Morning', '1234567894', 'emma.williams@example.com'),
    ('Oliver', 'Johnson', 'Evening', '1234567895', 'oliver.johnson@example.com');

-- ========================================
-- Room Table
-- ========================================
-- This table keeps track of rooms in the hospital and their availability.

CREATE TABLE Room (
    room_id SERIAL PRIMARY KEY,  -- Unique room identifier
    room_number VARCHAR(10) NOT NULL,  -- Room number (e.g., '101')
    room_type VARCHAR(50) NOT NULL,  -- Room type (e.g., 'ICU', 'General', 'Emergency')
    availability_status VARCHAR(20) NOT NULL CHECK (availability_status IN ('Available', 'Occupied')),  -- Room availability status
    floor INT NOT NULL  -- Floor where the room is located
);

-- Sample Insertion into Room Table
INSERT INTO Room (room_number, room_type, availability_status, floor)
VALUES
    ('101', 'ICU', 'Available', 1),
    ('102', 'General', 'Occupied', 1),
    ('103', 'Emergency', 'Available', 2);

-- ========================================
-- Appointment Table
-- ========================================
-- This table holds patient appointments with doctors.

CREATE TABLE Appointment (
    appointment_id SERIAL PRIMARY KEY,  -- Unique appointment identifier
    patient_id INT NOT NULL,  -- Foreign key referring to the Patient table
    doctor_id INT NOT NULL,  -- Foreign key referring to the Doctor table
    appointment_date DATE NOT NULL,  -- Date of appointment
    appointment_time TIME NOT NULL,  -- Time of appointment
    reason_for_visit TEXT,  -- Reason for the patient's visit
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),  -- Establishing relationship with the Patient table
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),  -- Establishing relationship with the Doctor table
    UNIQUE (appointment_date, appointment_time, doctor_id)  -- Prevent multiple appointments with the same doctor at the same time
);

-- Sample Insertion into Appointment Table
INSERT INTO Appointment (patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit)
VALUES
    (1, 1, '2025-06-15', '09:00:00', 'Heart checkup'),
    (2, 2, '2025-06-16', '10:00:00', 'Headache treatment');

-- ========================================
-- Admission Table
-- ========================================
-- This table stores patient admission details, including room assignments.

CREATE TABLE Admission (
    admission_id SERIAL PRIMARY KEY,  -- Unique admission identifier
    patient_id INT NOT NULL,  -- Foreign key referring to the Patient table
    room_id INT NOT NULL,  -- Foreign key referring to the Room table
    admission_date DATE NOT NULL,  -- Date of admission
    discharge_date DATE,  -- Date of discharge (nullable)
    room_charge DECIMAL(10, 2) NOT NULL CHECK (room_charge >= 0),  -- Charge for the room
    doctor_id INT NOT NULL,  -- Foreign key referring to the Doctor table
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),  -- Establishing relationship with the Patient table
    FOREIGN KEY (room_id) REFERENCES Room(room_id),  -- Establishing relationship with the Room table
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)  -- Establishing relationship with the Doctor table
);

-- Sample Insertion into Admission Table
INSERT INTO Admission (patient_id, room_id, admission_date, room_charge, doctor_id)
VALUES
    (1, 1, '2025-06-15', 500.00, 1),
    (2, 2, '2025-06-16', 300.00, 2);

-- ========================================
-- Treatment Table
-- ========================================
-- This table tracks the treatments given to patients during admission.

CREATE TABLE Treatment (
    treatment_id SERIAL PRIMARY KEY,  -- Unique treatment identifier
    admission_id INT NOT NULL,  -- Foreign key referring to the Admission table
    treatment_type VARCHAR(100) NOT NULL,  -- Type of treatment (e.g., Surgery, Medication)
    treatment_description TEXT,  -- Detailed description of the treatment
    treatment_date DATE NOT NULL,  -- Date of treatment
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id)  -- Establishing relationship with the Admission table
);

-- Sample Insertion into Treatment Table
INSERT INTO Treatment (admission_id, treatment_type, treatment_description, treatment_date)
VALUES
    (1, 'Surgery', 'Bypass surgery on the heart', '2025-06-16'),
    (2, 'Medication', 'Prescribed for headaches', '2025-06-17');

-- ========================================
-- Bill Table
-- ========================================
-- This table manages patient billing details.

CREATE TABLE Bill (
    bill_id SERIAL PRIMARY KEY,  -- Unique bill identifier
    admission_id INT NOT NULL,  -- Foreign key referring to the Admission table
    bill_amount DECIMAL(10, 2) NOT NULL CHECK (bill_amount >= 0),  -- Total bill amount
    payment_status VARCHAR(20) NOT NULL CHECK (payment_status IN ('Paid', 'Pending')),  -- Payment status
    payment_date DATE,  -- Payment date (nullable)
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id)  -- Establishing relationship with the Admission table
);

-- Sample Insertion into Bill Table
INSERT INTO Bill (admission_id, bill_amount, payment_status, payment_date)
VALUES
    (1, 1500.00, 'Paid', '2025-06-18'),
    (2, 1000.00, 'Pending', NULL);

-- ========================================
-- Views for Easy Access
-- ========================================
-- View to display doctor appointments along with patient details

CREATE VIEW doctor_appointments AS
SELECT
    a.appointment_id,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    a.appointment_date,
    a.appointment_time,
    a.reason_for_visit
FROM
    Appointment a
    JOIN Patient p ON a.patient_id = p.patient_id
    JOIN Doctor d ON a.doctor_id = d.doctor_id;

-- View to display patient billing details

CREATE VIEW patient_bills AS
SELECT
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    b.bill_amount,
    b.payment_status,
    b.payment_date
FROM
    Bill b
    JOIN Admission a ON b.admission_id = a.admission_id
    JOIN Patient p ON a.patient_id = p.patient_id;

-- ========================================
-- Indexes to Improve Query Performance
-- ========================================

-- Index for searching by patient name
CREATE INDEX idx_patient_name ON Patient (first_name, last_name);

-- Index for searching by doctor specialty
CREATE INDEX idx_doctor_specialisation ON Doctor (specialisation);

-- Index for searching by appointment date/time
CREATE INDEX idx_appointment_date_time ON Appointment (appointment_date, appointment_time);

-- ========================================
-- Stored Procedures for Managing Appointments
-- ========================================
-- Procedure to book an appointment for a patient

CREATE OR REPLACE FUNCTION book_appointment(patient_id INT, doctor_id INT, appointment_date DATE, appointment_time TIME, reason TEXT) RETURNS VOID AS $$
BEGIN
    -- Insert new appointment record
    INSERT INTO Appointment (patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit)
    VALUES (patient_id, doctor_id, appointment_date, appointment_time, reason);
END;
$$ LANGUAGE plpgsql;

-- ========================================
-- Trigger to Update Room Availability After Admission
-- ========================================
-- Trigger function to update the room's availability status when a patient is admitted

CREATE OR REPLACE FUNCTION update_room_availability() RETURNS TRIGGER AS $$
BEGIN
    -- Update room availability status to 'Occupied'
    UPDATE Room
    SET availability_status = 'Occupied'
    WHERE room_id = NEW.room_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for the Admission Table
CREATE TRIGGER trigger_update_room_availability
AFTER INSERT ON Admission
FOR EACH ROW
EXECUTE FUNCTION update_room_availability();

-- ========================================
-- Sample Queries for Data Retrieval
-- ========================================
-- Query to retrieve all appointments for a specific doctor
SELECT * FROM doctor_appointments WHERE doctor_first_name = 'Alice';

-- Query to retrieve the bill status for a particular patient
SELECT * FROM patient_bills WHERE patient_first_name = 'John' AND patient_last_name = 'Doe';

