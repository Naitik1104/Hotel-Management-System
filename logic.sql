USE Hotel_Management_System;

DELIMITER $$

CREATE TRIGGER booking_status_update
AFTER UPDATE ON bookings
FOR EACH ROW
BEGIN
    DECLARE new_room_status ENUM('available', 'occupied', 'reserved', 'maintenance');

    -- Map booking.status to room_status:
    SET new_room_status = CASE NEW.status
        WHEN 'booked' THEN 'reserved'
        WHEN 'checked-in' THEN 'occupied'
        WHEN 'checked-out' THEN 'available'
        WHEN 'cancelled' THEN 'available'
        ELSE (SELECT current_status FROM rooms WHERE room_id = NEW.room_id)
    END;

    IF OLD.status != NEW.status THEN
        -- Insert into room_status_log
        INSERT INTO room_status_log (room_id, previous_status, new_status, changed_at)
        VALUES (NEW.room_id, (SELECT current_status FROM rooms WHERE room_id = NEW.room_id), new_room_status, NOW());

        -- Update room current_status
        UPDATE rooms
        SET current_status = new_room_status
        WHERE room_id = NEW.room_id;
    END IF;
END$$

DELIMITER ;


CREATE TRIGGER total_bookings_update
AFTER INSERT ON bookings
FOR EACH ROW
BEGIN
    DECLARE room_type VARCHAR(20);
    SELECT room_type_name INTO room_type
    FROM rooms
    WHERE room_id = NEW.room_id;

    UPDATE room_types
    SET total_bookings = total_bookings + 1
    WHERE type_name = room_type;
END$$

CREATE PROCEDURE get_available_rooms()
BEGIN
    SELECT room_id, room_number
    FROM rooms
    WHERE current_status = 'available';
END$$

DELIMITER ;


CREATE VIEW view_invoices_paid AS
SELECT 
    i.invoice_id,
    i.booking_id,
    i.total_amount,
    IFNULL(SUM(p.amount_paid), 0) AS paid_amount,
    i.total_amount - IFNULL(SUM(p.amount_paid), 0) AS balance_due
FROM invoices i
LEFT JOIN payments p ON i.booking_id = p.booking_id
GROUP BY i.invoice_id, i.booking_id, i.total_amount;
