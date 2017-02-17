DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT2
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT2
);

CREATE TABLE tickets(
  customer_id INT4 REFERENCES customers(id),
  film_id INT4 REFERENCES films(id)
);