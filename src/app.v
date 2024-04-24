module main

import x.vweb
import x.sessions

pub struct Context {
	vweb.Context
	sessions.CurrentSession[User]
}

pub struct App {
	vweb.Middleware[Context]
	vweb.StaticHandler
pub mut:
	sessions &sessions.Sessions[User]
}
