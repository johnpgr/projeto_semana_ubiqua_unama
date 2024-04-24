module main

import x.vweb
import x.sessions
import x.sessions.vweb2_middleware

fn main() {
	println('Hello World!')

	conn := get_connection_mem()
	store := sessions.DBStore.create[User](conn) or { panic(err) }

	mut app := &App{
		sessions: &sessions.Sessions[User]{
			secret: 'my_secret'.bytes()
			store: store
		}
	}

	app.use(vweb2_middleware.create[User, Context](mut app.sessions))
	app.handle_static('assets', true) or { panic(err) }

	vweb.run[App, Context](mut app, 3000)
}
