--create tables and assign foreign keys

CREATE TABLE salesperson(
    salesperson_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    title VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE invoice(
    invoice_id SERIAL PRIMARY KEY,
    invoice_date date NOT NULL,
    salesperson_id integer,
  	FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id)
);

ALTER TABLE salesperson
ADD COLUMN invoice_id integer;

ALTER TABLE salesperson
ADD FOREIGN key(invoice_id) REFERENCES invoice(invoice_id);

CREATE TABLE customer(
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL,
    invoice_id integer,
    FOREIGN KEY(invoice_id) REFERENCES invoice(invoice_id)
);
    
ALTER TABLE invoice
ADD COLUMN customer_id integer;

ALTER TABLE invoice
ADD FOREIGN key(customer_id) REFERENCES customer(customer_id);

CREATE TABLE car(
    car_id SERIAL PRIMARY KEY,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(20) NOT NULL,
    color VARCHAR(20) NOT NULL,
    year smallint NOT NULL,
    price integer,
    serial_no integer NOT null,
    invoice_id integer,
    FOREIGN key(invoice_id) REFERENCES invoice(invoice_id),
    ticket_id integer,
    service_record integer
);

ALTER TABLE invoice
ADD COLUMN car_id integer;

ALTER TABLE invoice
ADD FOREIGN key(car_id) REFERENCES car(car_id);

--using non-primary key as foreign key requires "unique" constraint:
-- see https://www.techonthenet.com/postgresql/unique.php and
--https://stackoverflow.com/questions/11966420/error-there-is-no-unique-constraint-matching-given-keys-for-referenced-table-b 
ALTER TABLE car
ADD CONSTRAINT serial_unique UNIQUE (serial_no);

CREATE TABLE service_record(
	service_record_id serial PRIMARY KEY,
	ticket_id integer,
	serial_no integer,
	foreign key(serial_no) REFERENCES car(serial_no)
);

--fixing a mistake
ALTER TABLE car
RENAME service_record TO service_record_id;

ALTER TABLE car
ADD FOREIGN key(service_record_id) REFERENCES service_record(service_record_id);

CREATE TABLE ticket(
	ticket_id serial PRIMARY KEY,
	service varchar(100) NOT NULL,
	ticket_date date NOT null,
	serial_no integer,
	foreign key(serial_no) REFERENCES car(serial_no),
	car_id integer,
	foreign key(car_id) REFERENCES car(car_id),
	mechanic_id integer
);

ALTER TABLE service_record
ADD FOREIGN KEY(ticket_id) REFERENCES ticket(ticket_id);

ALTER TABLE car
ADD FOREIGN KEY(ticket_id) REFERENCES ticket(ticket_id);

CREATE TABLE mechanic(
	mechanic_id serial PRIMARY KEY,
	full_name varchar(50) NOT NULL,
	title varchar(50) NOT NULL,
	ticket_id integer,
	FOREIGN key(ticket_id) REFERENCES ticket(ticket_id)
);

ALTER TABLE ticket
ADD FOREIGN key(mechanic_id) REFERENCES mechanic(mechanic_id);

--fix other mistakes
ALTER TABLE customer
ALTER COLUMN invoice_id
DROP NOT NULL;

ALTER TABLE customer
ADD COLUMN ticket_id integer;

ALTER TABLE customer
ADD FOREIGN key(ticket_id) REFERENCES ticket(ticket_id);

ALTER TABLE ticket
ADD COLUMN price integer;