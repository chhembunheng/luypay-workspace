-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(255) NOT NULL UNIQUE,
    kyc_status VARCHAR(50),
    created_at TIMESTAMP NOT NULL,
    created_by VARCHAR(255),
    updated_at TIMESTAMP,
    updated_by VARCHAR(255),
    deleted_at TIMESTAMP,
    deleted_by VARCHAR(255)
);

-- Create index on email for faster lookups
CREATE INDEX idx_users_email ON users(email);

-- Create index on phone_number for faster lookups
CREATE INDEX idx_users_phone_number ON users(phone_number);

-- Create index on kyc_status for filtering
CREATE INDEX idx_users_kyc_status ON users(kyc_status);

