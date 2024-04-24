module main

@[table: 'product']
pub struct Product {
	id          int       @[sql: 'serial']
	name        string
	description string
	image_url   string
	price       int
	ratings     []Rating  @[fkey: 'product_id']
	comments    []Comment @[fkey: 'product_id']
}

@[table: 'rating']
pub struct Rating {
	id         int @[sql: 'serial']
	user_id    int @[references: 'user(id)']
	product_id int @[references: 'product(id)']
	value      int
}

@[table: 'comment']
pub struct Comment {
	id         int    @[sql: 'serial']
	user_id    int    @[references: 'user(id)']
	product_id int    @[references: 'product(id)']
	content    string
}
