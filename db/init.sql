CREATE TABLE trips (
  id SERIAL PRIMARY KEY,
  city TEXT NOT NULL,
  minutes INT NOT NULL,
  fare NUMERIC(6,2) NOT NULL
);

INSERT INTO trips (city, minutes, fare) VALUES
  ('Charlotte', 12, 12.50),
  ('Charlotte', 21, 20.00),
  ('New York', 9, 10.90),
  ('New York', 26, 27.10),
  ('San Francisco', 11, 11.20),
  ('San Francisco', 28, 29.30),
  ('Atlanta', 18, 17.50),
  ('Atlanta', 28, 26.00),
  ('Dubai', 35, 42.00),
  ('Dubai', 22, 25.50),
  ('London', 35, 38.00),
  ('Lisbon', 16, 14.00);
