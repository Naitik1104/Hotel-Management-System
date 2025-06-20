use Hotel_management_system;

CREATE TABLE room_types (
    type_name VARCHAR(20) PRIMARY KEY,
    base_price DECIMAL(10,2) NOT NULL,
    amenities TEXT,
    no_of_rooms INT DEFAULT 0,
    total_bookings INT DEFAULT 0
);

CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type_name VARCHAR(20) NOT NULL,
    capacity INT NOT NULL,
    floor INT NOT NULL,
    current_status ENUM('available','occupied','maintenance','reserved') NOT NULL DEFAULT 'available',
    price_category ENUM('standard', 'premium', 'deluxe', 'suite') NOT NULL,
    
    FOREIGN KEY (room_type_name) REFERENCES room_types(type_name)
);

CREATE TABLE room_status_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT NOT NULL,
    previous_status ENUM('available','occupied','maintenance','reserved'),
    new_status ENUM('available','occupied','maintenance','reserved') NOT NULL,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

----

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    id_proof_type ENUM('Aadhar','Passport','Driving License','PAN','Other') NOT NULL,
    id_proof_number VARCHAR(50) NOT NULL,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATETIME NOT NULL,
    check_out DATETIME NOT NULL,
    status ENUM('booked','checked-in','checked-out','cancelled') NOT NULL DEFAULT 'booked',
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE booking_guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    guest_name VARCHAR(100) NOT NULL,
    guest_id_proof_type ENUM('Aadhar','Passport','Driving License','PAN','Other'),
    guest_id_proof_number VARCHAR(50),
    
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

CREATE TABLE customer_feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comments TEXT,
    feedback_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

----

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash', 'Debit Card', 'Credit Card', 'UPI', 'Netbanking') NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

CREATE TABLE invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    invoice_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

----

CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    shift ENUM('Morning','Evening','Night','Full Day','Fluctuating') NOT NULL,
    role ENUM('Receptionist','Manager','Housekeeping','Kitchen','Maintenance','Security','Other') NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE staff_activity_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT NOT NULL,
    booking_id INT,
    action_type ENUM('Check-In','Check-Out','Room Assignment','Room Status Change','Cleaning','Other') NOT NULL,
    action_details TEXT,
    action_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);
    
----

CREATE TABLE services (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    service_name VARCHAR(100) UNIQUE NOT NULL,
    service_description TEXT,
    service_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE booking_services (
    booking_service_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT DEFAULT 1,
    
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

----

CREATE TABLE seasonal_pricing (
    season_id INT PRIMARY KEY AUTO_INCREMENT,
    season_name VARCHAR(50) NOT NULL,
    room_type_name VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    season_price DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (room_type_name) REFERENCES room_types(type_name)
);

CREATE TABLE room_pricing_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type_name VARCHAR(20) NOT NULL,
    old_price DECIMAL(10,2) NOT NULL,
    new_price DECIMAL(10,2) NOT NULL,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (room_type_name) REFERENCES room_types(type_name)
);

CREATE TABLE booking_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    customer_id INT,
    room_id INT,
    check_in DATETIME,
    check_out DATETIME,
    status ENUM('booked','checked-in','checked-out','cancelled'),
    archived_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

