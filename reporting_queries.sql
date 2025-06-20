use Hotel_Management_System;
-- 1. Available rooms between '2025-06-19' and '2025-06-20'
SELECT r.room_id, r.room_number
FROM rooms r
WHERE r.room_id NOT IN (
    SELECT b.room_id
    FROM bookings b
    WHERE b.status IN ('booked', 'checked-in')
    AND (b.check_out >= '2025-06-19' AND b.check_in <= '2025-06-21')
);

-- 2. Monthly occupancy rate for each room type
SELECT 
    DATE_FORMAT(b.check_in, '%Y-%m') AS month,
    rt.type_name AS room_type,
    COUNT(b.booking_id) AS bookings_count,
    ROUND((COUNT(b.booking_id) / (COUNT(DISTINCT r.room_id) * 30)) * 100, 2) AS approx_occupancy_rate_percent
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
JOIN room_types rt ON r.room_type_name = rt.type_name
WHERE b.status IN ('booked', 'checked-in', 'checked-out')
GROUP BY month, room_type
ORDER BY month, room_type;

-- 3. Total revenue by season 
SELECT sp.season_name, 
    SUM(i.total_amount) AS total_revenue
FROM seasonal_pricing sp
JOIN rooms r ON r.room_type_name = sp.room_type_name
JOIN bookings b ON b.room_id = r.room_id
JOIN invoices i ON i.booking_id = b.booking_id
WHERE b.check_in BETWEEN sp.start_date AND sp.end_date
GROUP BY sp.season_name;

-- 4.bookings with highest outstanding payments
SELECT 
    b.booking_id,
    c.name AS customer_name,
    i.total_amount,
    IFNULL(SUM(p.amount), 0) AS total_paid,
    (i.total_amount - IFNULL(SUM(p.amount), 0)) AS balance_due
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN invoices i ON i.booking_id = b.booking_id
LEFT JOIN payments p ON p.booking_id = b.booking_id
GROUP BY b.booking_id, c.name, i.total_amount
HAVING balance_due > 0
ORDER BY balance_due DESC;

-- 5. Customers with most bookings
SELECT c.customer_id, 
c.name, 
COUNT(b.booking_id) AS no_of_bookings
FROM customers c
LEFT JOIN bookings b ON b.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY no_of_bookings DESC;

-- 5. Customers with highest spend
SELECT c.customer_id, 
    c.name,
    SUM(p.amount) AS total_spend
FROM customers c
JOIN bookings b on b.customer_id = c.customer_id
JOIN payments p on p.booking_id = b.booking_id
GROUP BY c.customer_id, c.name
ORDER BY total_spend DESC;

-- 6.Staff who performed check-ins on specific day
SELECT 
    s.staff_id,
    s.name AS staff_name,
    COUNT(l.log_id) AS checkins_done,
    DATE(l.action_time) AS action_date
FROM staff_activity_log l
JOIN staff s ON l.staff_id = s.staff_id
WHERE l.action_type = 'check-in'
AND DATE(l.action_time) = '2025-06-20'  
GROUP BY s.staff_id, s.name, action_date
ORDER BY checkins_done DESC;


-- 7. Services used per booking (with total service charges)
SELECT 
    b.booking_id,
    c.name AS customer_name,
    s.service_name,
    bs.quantity,
    (s.service_price * bs.quantity) AS total_service_charge
FROM booking_services bs
JOIN bookings b ON bs.booking_id = b.booking_id
JOIN customers c ON b.customer_id = c.customer_id
JOIN services s ON bs.service_id = s.service_id
ORDER BY b.booking_id, s.service_name;

-- 8.Rooms reserved but not yet checked-in
SELECT 
    b.booking_id, 
    c.name AS customer_name, 
    r.room_number, 
    b.check_in, 
    b.status
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN rooms r ON b.room_id = r.room_id
WHERE b.status = 'booked'
ORDER BY b.check_in ASC;


-- Customers with full payments and good feedback (best customers ranking)
SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(DISTINCT b.booking_id) AS total_bookings,
    ROUND(AVG(f.rating), 2) AS avg_rating,
    SUM(i.total_amount) AS total_amount_spent
FROM customers c
JOIN bookings b ON b.customer_id = c.customer_id
JOIN invoices i ON i.booking_id = b.booking_id
LEFT JOIN payments p ON p.booking_id = b.booking_id
JOIN customer_feedback f ON f.booking_id = b.booking_id
GROUP BY c.customer_id, c.name
HAVING SUM(i.total_amount) - IFNULL(SUM(p.amount), 0) = 0 
ORDER BY avg_rating DESC, total_bookings DESC, total_amount_spent DESC
LIMIT 5;






