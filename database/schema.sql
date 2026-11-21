-- racelink schema (mysql 8)

DROP TABLE IF EXISTS event_documents;
DROP TABLE IF EXISTS payment_proofs;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS marathon_tshirt_sizes;
DROP TABLE IF EXISTS marathon_distances;
DROP TABLE IF EXISTS marathon_events;
DROP TABLE IF EXISTS runner_profiles;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  name            VARCHAR(100) NOT NULL,
  email           VARCHAR(255) NOT NULL,
  password_hash   VARCHAR(255) NOT NULL,
  role            ENUM('runner', 'organizer', 'admin') NOT NULL DEFAULT 'runner',
  date_registered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT uq_users_email UNIQUE (email)
);

CREATE TABLE runner_profiles (
  id                       INT AUTO_INCREMENT PRIMARY KEY,
  user_id                  INT NOT NULL,
  address                  VARCHAR(255),
  phone                    VARCHAR(30),
  gender                   ENUM('Male', 'Female', 'Other'),
  birthdate                DATE,
  emergency_contact_name   VARCHAR(100),
  emergency_contact_number VARCHAR(30),
  CONSTRAINT uq_runner_profiles_user UNIQUE (user_id),
  CONSTRAINT fk_runner_profiles_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE marathon_events (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  title        VARCHAR(150) NOT NULL,
  description  TEXT,
  event_date   DATE NOT NULL,
  location     VARCHAR(255) NOT NULL,
  organizer_id INT NOT NULL,
  created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_marathon_events_organizer FOREIGN KEY (organizer_id) REFERENCES users (id)
);

CREATE TABLE marathon_distances (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  marathon_id INT NOT NULL,
  distance    VARCHAR(20) NOT NULL,
  price       DECIMAL(10, 2) NOT NULL,
  CONSTRAINT uq_marathon_distance UNIQUE (marathon_id, distance),
  CONSTRAINT ck_marathon_distances_price CHECK (price >= 0),
  CONSTRAINT fk_marathon_distances_event FOREIGN KEY (marathon_id) REFERENCES marathon_events (id) ON DELETE CASCADE
);

CREATE TABLE marathon_tshirt_sizes (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  marathon_id INT NOT NULL,
  size        ENUM('XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL') NOT NULL,
  CONSTRAINT uq_marathon_size UNIQUE (marathon_id, size),
  CONSTRAINT fk_marathon_tshirt_sizes_event FOREIGN KEY (marathon_id) REFERENCES marathon_events (id) ON DELETE CASCADE
);

CREATE TABLE bookings (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  user_id        INT NOT NULL,
  marathon_id    INT NOT NULL,
  distance       VARCHAR(20) NOT NULL,
  price          DECIMAL(10, 2) NOT NULL,
  tshirt_size    ENUM('XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL') NOT NULL,
  payment_status ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
  bib_number     INT NULL,
  attended       BOOLEAN NOT NULL DEFAULT FALSE,
  checked_in_at  DATETIME NULL,
  created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT uq_bookings_runner_event UNIQUE (user_id, marathon_id),
  CONSTRAINT uq_bookings_bib UNIQUE (marathon_id, bib_number),
  CONSTRAINT fk_bookings_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_bookings_event FOREIGN KEY (marathon_id) REFERENCES marathon_events (id) ON DELETE CASCADE
);

CREATE TABLE payment_proofs (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  booking_id  INT NOT NULL,
  file_path   VARCHAR(512) NOT NULL,
  amount      DECIMAL(10, 2) NOT NULL,
  status      ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
  uploaded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT uq_payment_proofs_booking UNIQUE (booking_id),
  CONSTRAINT ck_payment_proofs_amount CHECK (amount > 0),
  CONSTRAINT fk_payment_proofs_booking FOREIGN KEY (booking_id) REFERENCES bookings (id) ON DELETE CASCADE
);

CREATE TABLE event_documents (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  marathon_id INT NOT NULL,
  file_name   VARCHAR(255) NOT NULL,
  file_path   VARCHAR(512) NOT NULL,
  uploaded_by INT NOT NULL,
  uploaded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_event_documents_event FOREIGN KEY (marathon_id) REFERENCES marathon_events (id) ON DELETE CASCADE,
  CONSTRAINT fk_event_documents_user FOREIGN KEY (uploaded_by) REFERENCES users (id)
);
