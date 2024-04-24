module main

import db.sqlite

pub fn get_connection_mem() sqlite.DB {
	return sqlite.connect(':memory:') or { panic(err) }
}

pub fn create_tables(conn sqlite.DB) {
	sql conn {
		create table User
		create table Product
		create table Rating
		create table Comment
	} or { panic(err) }
}
