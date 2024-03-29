package db

import "database/sql"

// Store provides all functions to execute all queries and transactions
type Store struct {
	*Queries
	db *sql.DB
}
