CREATE DATABASE EventFinderDBMS;
USE EventFinderDBMS;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    role ENUM('User', 'Admin', 'Organizer'),
    account_status ENUM('Active', 'Inactive', 'Suspended'),
    premium_membership TINYINT DEFAULT 0
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    popularity_score INT DEFAULT 0
);

CREATE TABLE Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    organizer_id INT,
    name VARCHAR(255) NOT NULL,
    category_id INT,
    date_time DATETIME NOT NULL,
    venue VARCHAR(255),
    status ENUM('Scheduled', 'Ongoing', 'Completed', 'Cancelled') NOT NULL,
    FOREIGN KEY (organizer_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE TicketBookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_id INT,
    payment_status ENUM('Pending', 'Completed', 'Cancelled') NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
 FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    amount DECIMAL(10,2) NOT NULL,
    method ENUM('Credit Card', 'Debit Card', 'PayPal', 'UPI', 'Bank Transfer') NOT NULL,
    transaction_state ENUM('Pending', 'Success', 'Failed', 'Refunded') NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    user_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE JobPostings (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    posted_by INT,
    title VARCHAR(255) NOT NULL,
    company VARCHAR(255) NOT NULL,
    type ENUM('Full-time', 'Part-time', 'Internship', 'Contract'),
    location VARCHAR(255),
    status ENUM('Open', 'Closed', 'Filled') NOT NULL,
    FOREIGN KEY (posted_by) REFERENCES Users(user_id)
);

CREATE TABLE ProfessionalNetwork (
    connection_id INT PRIMARY KEY AUTO_INCREMENT,
    requester_id INT,
    receiver_id INT,
    connection_status ENUM('Pending', 'Accepted', 'Rejected') NOT NULL,
    FOREIGN KEY (requester_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);


CREATE TABLE Messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    content TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    seen_status TINYINT DEFAULT 0,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);

CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    notification_type ENUM('Message', 'Event Reminder', 'Job Alert', 'Payment Alert') NOT NULL,
    read_status TINYINT DEFAULT 0,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

show tables;
