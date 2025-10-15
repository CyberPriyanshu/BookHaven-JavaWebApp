-- BookHaven Database Schema for PostgreSQL

-- Create database (run separately if needed)
-- CREATE DATABASE bookhaven;

-- Connect to the database
-- \c bookhaven;

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS contacts CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS admins CASCADE;

-- Create admins table
CREATE TABLE admins (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create books table
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    featured BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create contacts table
CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample admin user (password: admin123)
-- Note: In production, passwords should be hashed
INSERT INTO admins (username, password, email) VALUES 
('admin', 'admin123', 'admin@bookhaven.com');

-- Insert sample books data
INSERT INTO books (title, author, isbn, category, price, description, featured) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '978-0743273565', 'Classic Fiction', 12.99, 'A classic novel depicting the decadence and excess of the Jazz Age.', true),
('To Kill a Mockingbird', 'Harper Lee', '978-0060935467', 'Classic Fiction', 14.99, 'A gripping tale of racial injustice and childhood innocence in the Deep South.', true),
('1984', 'George Orwell', '978-0451524935', 'Science Fiction', 13.99, 'A dystopian social science fiction novel and cautionary tale.', true),
('Pride and Prejudice', 'Jane Austen', '978-0141439518', 'Romance', 11.99, 'A romantic novel of manners set in Georgian England.', true),
('The Catcher in the Rye', 'J.D. Salinger', '978-0316769174', 'Coming of Age', 12.99, 'A story about teenage rebellion and alienation.', true),
('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', '978-0590353427', 'Fantasy', 16.99, 'The first book in the beloved Harry Potter series.', true),
('The Hobbit', 'J.R.R. Tolkien', '978-0547928227', 'Fantasy', 15.99, 'A fantasy adventure about Bilbo Baggins and his journey.', false),
('The Lord of the Rings', 'J.R.R. Tolkien', '978-0544003415', 'Fantasy', 25.99, 'An epic high-fantasy novel that started it all.', false),
('Dune', 'Frank Herbert', '978-0441172719', 'Science Fiction', 18.99, 'A science fiction novel set in the distant future.', false),
('The Alchemist', 'Paulo Coelho', '978-0062315007', 'Philosophy', 14.99, 'A philosophical book about following your dreams.', false);

-- Insert sample contact data (optional)
INSERT INTO contacts (name, email, phone, message) VALUES
('John Doe', 'john.doe@example.com', '+1234567890', 'I would like to know more about your book collection.'),
('Jane Smith', 'jane.smith@example.com', '+1987654321', 'Do you have any books on programming?');

-- Display confirmation
SELECT 'Database schema created successfully!' AS status;
SELECT 'Admin user created - Username: admin, Password: admin123' AS info;
SELECT COUNT(*) AS total_books FROM books;
SELECT COUNT(*) AS total_contacts FROM contacts;
