-- 1. Creating the Users Table 
CREATE TABLE users (
    user_id VARCHAR(50),
    name VARCHAR(50),
    phone_number VARCHAR(20),
    mail_id VARCHAR(50),
    billing_address VARCHAR(100)
);

-- Putting data into Users Table 
INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) 
VALUES ('21wrcxuy-67erfn', 'John Doe', '97XXXXXXXX', 'john.doe@example.com', 'XX, Street Y, ABC City');


-- 2. Creating the Bookings Table 
CREATE TABLE bookings (
    booking_id VARCHAR(50),
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50)
);

-- Putting data into Bookings Table 
INSERT INTO bookings (booking_id, booking_date, room_no, user_id) 
VALUES ('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn');


-- 3. Creating the Items Table 
CREATE TABLE items (
    item_id VARCHAR(50),
    item_name VARCHAR(50),
    item_rate INTEGER
);

-- Putting data into Items Table 
INSERT INTO items (item_id, item_name, item_rate) 
VALUES 
('itm-a9e8-q8fu', 'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg', 89),
('itm-w978-23u4', 'Paneer Butter Masala', 120);


-- 4. Creating the Booking Commercials Table 
CREATE TABLE booking_commercials (
    id VARCHAR(50),
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(5,2)
);

-- Putting data into Booking Commercials Table 
INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) 
VALUES 
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:05:37', 'itm-w978-23u4', 0.5);
