-- sample data, password ng lahat: racelink123

INSERT INTO users (id, name, email, password_hash, role) VALUES
  (1, 'Jane Smith',  'organizer@racelink.test', '$2b$10$IS8mLcvy4UHzKFBjMbPx3.MzQxf4xZnoIDCcR/kCxDJDOppjfxJ1S', 'organizer'),
  (2, 'Enzo Azuelo', 'enzo@racelink.test',      '$2b$10$IS8mLcvy4UHzKFBjMbPx3.MzQxf4xZnoIDCcR/kCxDJDOppjfxJ1S', 'runner'),
  (3, 'Paris Alejandrino', 'paris@racelink.test', '$2b$10$IS8mLcvy4UHzKFBjMbPx3.MzQxf4xZnoIDCcR/kCxDJDOppjfxJ1S', 'runner');

INSERT INTO runner_profiles (user_id, address, phone, gender, birthdate, emergency_contact_name, emergency_contact_number) VALUES
  (2, 'Malolos, Bulacan',  '09171234567', 'Male',   '2004-05-12', 'Ardyson Marcelo', '09181234567'),
  (3, 'Caloocan City',     '09271234567', 'Female', '2003-11-02', 'Riel Roque',      '09281234567');

INSERT INTO marathon_events (id, title, description, event_date, location, organizer_id) VALUES
  (1, 'Caloocan City Run',     'A flat loop around the city center, open to all levels.', '2027-02-14', 'Caloocan City',       1),
  (2, 'Manila Bay Sunset Run', 'Run along Roxas Boulevard as the sun goes down.',          '2027-03-21', 'Roxas Blvd, Manila',  1),
  (3, 'BGC Night Dash',        'A fast night course through Bonifacio Global City.',       '2027-04-10', 'Taguig City',         1),
  (4, 'Valenzuela Fun Run',    'Short family-friendly course with a festival finish.',     '2027-05-02', 'Valenzuela City',     1),
  (5, 'Tagaytay Ridge Climb',  'Hilly route with views of Taal Lake.',                     '2027-06-19', 'Tagaytay, Cavite',    1);

INSERT INTO marathon_distances (marathon_id, distance, price) VALUES
  (1, '5KM', 500.00), (1, '10KM', 650.00), (1, '21KM', 900.00),
  (2, '5KM', 550.00), (2, '10KM', 700.00),
  (3, '3KM', 400.00), (3, '10KM', 750.00),
  (4, '3KM', 300.00), (4, '5KM', 400.00),
  (5, '10KM', 800.00), (5, '21KM', 1100.00);

INSERT INTO marathon_tshirt_sizes (marathon_id, size) VALUES
  (1, 'S'), (1, 'M'), (1, 'L'), (1, 'XL'),
  (2, 'XS'), (2, 'S'), (2, 'M'), (2, 'L'), (2, 'XL'), (2, 'XXL'),
  (3, 'S'), (3, 'M'), (3, 'L'),
  (4, 'XS'), (4, 'S'), (4, 'M'), (4, 'L'), (4, 'XL'),
  (5, 'M'), (5, 'L'), (5, 'XL'), (5, 'XXL');

INSERT INTO bookings (id, user_id, marathon_id, distance, price, tshirt_size, payment_status, bib_number) VALUES
  (1, 2, 1, '10KM', 650.00, 'M', 'approved', 1),
  (2, 3, 1, '21KM', 900.00, 'S', 'approved', 2),
  (3, 2, 2, '5KM',  550.00, 'M', 'pending',  NULL);

INSERT INTO payment_proofs (booking_id, file_path, amount, status) VALUES
  (1, 'payment-proofs/1/1-sample.jpg', 650.00, 'approved'),
  (2, 'payment-proofs/1/2-sample.jpg', 900.00, 'approved'),
  (3, 'payment-proofs/2/3-sample.jpg', 550.00, 'pending');
