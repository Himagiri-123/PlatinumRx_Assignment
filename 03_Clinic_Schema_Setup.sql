-- 1. Creating Clinics Table 
CREATE TABLE clinics (
    cid VARCHAR(50),
    clinic_name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

-- Putting data into Clinics Table 
INSERT INTO clinics (cid, clinic_name, city, state, country)
VALUES ('cnc-0100001', 'XYZ clinic', 'lorem', 'ipsum', 'dolor');


-- 2. Creating Customer Table 
CREATE TABLE customer (
    uid VARCHAR(50),
    name VARCHAR(50),
    mobile VARCHAR(20)
);

-- Putting data into Customer Table 
INSERT INTO customer (uid, name, mobile)
VALUES ('bk-09f3e-95hj', 'Jon Doe', '97XXXXXXXX');


-- 3. Creating Clinic Sales Table 
CREATE TABLE clinic_sales (
    oid VARCHAR(50),
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50)
);

-- Putting data into Clinic Sales Table 
INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel)
VALUES ('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'sodat');


-- 4. Creating Expenses Table 
CREATE TABLE expenses (
    eid VARCHAR(50),
    cid VARCHAR(50),
    description VARCHAR(100),
    amount DECIMAL(10,2),
    datetime DATETIME
);

-- Putting data into Expenses Table 
INSERT INTO expenses (eid, cid, description, amount, datetime)
VALUES ('exp-0100-00100', 'cnc-0100001', 'first-aid supplies', 557, '2021-09-23 07:36:48');