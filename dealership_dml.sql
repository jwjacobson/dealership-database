--Mostly DML with some DDL based on revised understanding of the project
--Populate salesperson, invoice, and customer

INSERT INTO invoice (
	invoice_date
)
VALUES (
	'2023-03-01'
);

insert INTO salesperson (
	full_name,
	title,
	email
)
VALUES (
	'Willy Sinecure Jr.',
	'Sales Associate',
	'wsinecurejr@surelyauto.com'
);

UPDATE invoice SET salesperson_id = 1 WHERE invoice_id = 1;

INSERT INTO invoice (
	invoice_date,
	salesperson_id
)
VALUES (
	'2023-03-10',
	2
);

UPDATE salesperson SET invoice_id =2 WHERE salesperson_id = 2;

insert INTO salesperson (
	full_name,
	title,
	email
)
VALUES (
	'Shirley S. Auto',
	'Owner',
	'shirley@surelyauto.com'
);

insert INTO customer (
	full_name,
	email,
	invoice_id
)
VALUES (
	'Ed Hufeisen',
	'ehoofs@gmail.com',
	'1'
);

insert INTO customer (
	full_name,
	email,
	invoice_id
)
VALUES (
	'Stella Estrella',
	'starstell135@yahoo.com',
	'2'
);

INSERT INTO car (
	make,
	model,
	color,
	YEAR,
	price,
	serial_no
)
VALUES (
	'AMC',
	'Gremlin',
	'chartreuse',
	1972,
	10000,
	11003434
);

INSERT INTO car (
	make,
	model,
	color,
	YEAR,
	price,
	serial_no
)
VALUES (
	'Geo',
	'Metro',
	'purple',
	1991,
	7000,
	22222222
);

INSERT INTO car (
	make,
	model,
	color,
	YEAR,
	price,
	serial_no
)
VALUES (
	'Ford',
	'Pinto',
	'brown',
	1977,
	50,
	73173177
);

INSERT INTO car (
	make,
	model,
	color,
	YEAR,
	price,
	serial_no
)
VALUES (
	'Toyota',
	'Kijang',
	'silver',
	2002,
	15000,
	45466389
);

UPDATE car SET invoice_id =2 WHERE car_id = 1;
UPDATE car SET invoice_id =1 WHERE car_id = 2;

UPDATE invoice SET car_id = 1 WHERE invoice_id = 2;
UPDATE invoice SET car_id = 2 WHERE invoice_id = 1;

UPDATE invoice SET customer_id = 1 WHERE invoice_id = 1;
UPDATE invoice SET customer_id = 2 WHERE invoice_id = 2;

INSERT INTO ticket (
	service,
	ticket_date,
	price,
	car_id,
	serial_no
)
VALUES (
	'brake overhaul',
	'1977-09-04',
	2000,
	3,
	73173177
	);

INSERT INTO ticket (
	service,
	ticket_date,
	price,
	car_id,
	serial_no
)
VALUES (
	'emissions test',
	'2010-05-07',
	200,
	4,
	45466389
	);

----make a PROCEDURE to fill service_record data
CREATE OR REPLACE PROCEDURE add_service_record(ticket_id integer, serial_no integer)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO service_record(ticket_id, serial_no)
    VALUES(ticket_id, serial_no);
END;
$$;

CALL add_service_record(1, 73173177);
CALL add_service_record(2, 45466389);

--making some alterations: realized service_record doesn't need a primary key,
--and the existence of service_record means ticket doesn't need serial_no

ALTER TABLE ticket
DROP COLUMN serial_no;

ALTER TABLE car
DROP constraint car_service_record_id_fkey;

ALTER TABLE service_record
ADD FOREIGN key(serial_no) REFERENCES car(serial_no); 

ALTER TABLE service_record DROP COLUMN service_record_id;

UPDATE car SET ticket_id = 1 WHERE car_id = 3;
UPDATE car SET ticket_id = 2 WHERE car_id = 4;

INSERT INTO mechanic (
	full_name,
	title
)
VALUES (
	'Marty H. Degger',
	'Sr. Mechanic'
	);

INSERT INTO mechanic (
	full_name,
	title
)
VALUES (
	'Peanut',
	'Jr. Mechanic'
	);

UPDATE mechanic SET ticket_id = 1 WHERE mechanic_id = 1;
UPDATE mechanic SET ticket_id = 2 WHERE mechanic_id = 2;
UPDATE ticket SET mechanic_id =1 WHERE ticket_id = 1;
UPDATE ticket SET mechanic_id =2 WHERE ticket_id = 2;

insert INTO customer (
	full_name,
	email
)
VALUES (
	'Ngatmo Bernapas',
	'ngatmowae@hotmail.com'
);

UPDATE customer SET ticket_id = 2 WHERE customer_id = 3;

--No one knows who brought in the Pinto back in '77, and no one's ever come to claim it. It's more of a museum piece now