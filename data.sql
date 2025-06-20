use Hotel_Management_System;

INSERT into room_types (type_name, base_price, amenities) VALUES 
('Single', 3000.00, 'TV, Wi-Fi, AC, Fridge, Single Bed'),
('Double', 4500.00, 'TV, Wi-Fi, AC, Fridge, Balcony, King-Size Bed'),
('Suite', 8500.00, 'TV, Wi-Fi, AC, Fridge, Balcony, King-Size Bed, Jacuzi, Kitchen');

INSERT INTO rooms (room_number, room_type_name, capacity, floor, current_status, price_category)
VALUES
('101', 'Suite', 4, 1, 'available', 'suite'),
('102', 'Single', 1, 1, 'available', 'standard'),
('201', 'Suite', 4, 2, 'occupied', 'suite'),
('202', 'Double', 2, 2, 'available', 'premium'),
('301', 'Suite', 4, 3, 'reserved', 'suite'),
('302', 'Single', 1, 3, 'available', 'standard'),
('303', 'Double', 2, 3, 'maintenance', 'premium');

INSERT INTO customers (name, contact_number, email, id_proof_type, id_proof_number)
VALUES
('Krishnan Chettiar', '9123', 'krishc@gmail.com', 'Aadhar', '1234-5678-9876'),
('Riya Sharma', '909090', 'riya123@yahoo.com', 'Passport', 'M12345678'),
('Harsh Dodeja', '91234', 'harshdodeja@hotmail.com', 'Driving License', 'DL-45231'),
('Sita Devi', '987612', 'sita@gmail.com', 'PAN', 'ABCDE1234F'),
('Rohit Sharma', '9454545', 'rs45@gmail.com', 'Aadhar', '1234-5678-9876'),
('Virat Kohli', '9181818', 'vk18@gmail.com', 'Aadhar', '1234-5678-9876');

INSERT INTO staff (name, role, shift, contact_number, email)
VALUES
('Priya Verma', 'Manager', 'Full-Day', '98234567', 'priya@hotel_vistara.com'),
('Arjun Kapoor', 'Receptionist', 'Morning', '98123456', 'arjun@hotel.com'),
('Ramesh Kumar', 'Housekeeping', 'Morning', '98345678', 'ramesh@hotel.com'),
('Catherine Fernandes', 'Receptionist', 'Evening', '9845678', 'catf19@gmail.com'),
('Jai Shukla', 'Security', 'Night', '984548', 'jaishukla@gmail.com'),
('Sheila Sen', 'Kitchen', 'Fluctuating', '909678', 'sheilasennn@gmail.com');

INSERT INTO services (service_name, service_description, service_price)
VALUES
('Breakfast', 'Continental Breakfast Buffet', 500.00),
('Spa', 'Full body spa session', 2500.00),
('Laundry', 'Wash & Iron per kg', 300.00),
('Airport Pickup', 'Pickup from airport', 1000.00);

 INSERT INTO seasonal_pricing (season_name, room_type_name, start_date, end_date, season_price)
VALUES
('Diwali', 'Single', '2025-10-15', '2025-11-10', 4300.00),
('Diwali', 'Double', '2025-10-15', '2025-11-10', 7800.00),
('Diwali', 'Suite', '2025-10-15', '2025-11-10', 12000.00),
('Christmas', 'Single', '2025-12-20', '2026-01-05', 4000.00),
('Christmas', 'Double', '2025-12-20', '2026-01-05', 700.00),
('Christmas', 'Suite', '2025-12-20', '2026-01-05', 10000.00),
('Summer Peak', 'Double', '2025-05-01', '2025-06-30', 8000.00),
('Summer Peak', 'Suite', '2025-05-01', '2025-06-30', 12500.00);
INSERT INTO bookings (customer_id, room_id, check_in, check_out, status)
VALUES
(1, 1, '2025-06-20 14:00:00', '2025-06-22 12:00:00', 'booked'),
(2, 2, '2025-06-19 12:00:00', '2025-06-21 11:00:00', 'checked-in'),
(3, 3, '2025-06-15 14:00:00', '2025-06-17 12:00:00', 'checked-out'),
(4, 5, '2025-06-18 14:00:00', '2025-06-21 12:00:00', 'cancelled'),
(5, 6, '2025-06-21 13:00:00', '2025-06-24 11:00:00', 'booked');

INSERT INTO invoices (booking_id, total_amount)
VALUES
(1, 5000.00),
(2, 4500.00),
(3, 8500.00),
(4, 4000.00),
(5, 6000.00);


INSERT INTO payments (booking_id, amount, payment_method)
VALUES
(1, 2000.00, 'UPI'),
(2, 3000.00, 'Debit Card'),
(3, 8500.00, 'Cash'),
(1, 1000.00, 'UPI'),
(5, 4500.00, 'UPI');

INSERT INTO booking_services (booking_id, service_id, quantity)
VALUES
(1, 1, 2),  
(1, 2, 1),  
(2, 3, 3), 
(3, 4, 1),  
(5, 1, 1);

INSERT INTO room_status_log (room_id, previous_status, new_status)
VALUES
(1, 'available', 'occupied'),
(2, 'available', 'occupied'),
(3, 'occupied', 'available'),
(5, 'reserved', 'available');

Select * from room_status_log;

INSERT INTO customer_feedback (booking_id, rating, comments)
VALUES
(3, 5, 'Amazing stay! Loved the service.'),
(2, 3, 'Good experience but room was a bit noisy.'),
(1, 5, 'Very comfortable and staff was friendly.');

INSERT INTO booking_guests (booking_id, guest_name, guest_id_proof_type, guest_id_proof_number)
VALUES
(1, 'Ankit Mehra', 'Aadhar', '9999-8888-7777'),
(1, 'Sunita Mehra', 'Aadhar', '6666-5555-4444'),
(2, 'Ravi Kumar', 'Passport', 'P12345678');





