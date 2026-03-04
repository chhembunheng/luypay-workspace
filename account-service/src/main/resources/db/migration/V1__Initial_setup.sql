-- Initial migration for account-service
-- This creates the initial schema for the account service

-- Create accounts table
CREATE TABLE IF NOT EXISTS accounts (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    account_number VARCHAR(50) UNIQUE NOT NULL,
    account_type VARCHAR(50) NOT NULL,
    balance DECIMAL(19, 4) NOT NULL DEFAULT 0.0000,
    currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(255),
    updated_at TIMESTAMP,
    updated_by VARCHAR(255),
    deleted_at TIMESTAMP,
    deleted_by VARCHAR(255)
);

-- Create index on user_id for faster lookups
CREATE INDEX idx_accounts_user_id ON accounts(user_id);

-- Create index on account_number for faster lookups
CREATE INDEX idx_accounts_account_number ON accounts(account_number);

-- Create index on status for filtering
CREATE INDEX idx_accounts_status ON accounts(status);
