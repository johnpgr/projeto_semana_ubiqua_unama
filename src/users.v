module main

import x.vweb
import crypto.bcrypt

@[table: 'user']
pub struct User {
pub mut:
	id              int    @[sql: 'serial']
	name            string
	email           string
	hashed_password string
}

pub fn User.new(name string, email string, password string) !User {
	if name.is_blank() || name.len > 16 || name.contains(' ') {
		return error('Nome de usuário ilegal. Máximo 16 carácteres, espaços em branco não permitido.')
	}

	hashed_password := bcrypt.generate_from_password(password.bytes(), 12)!

	return User{
		name: name
		email: email
		hashed_password: hashed_password
	}
}

@['/api/signup'; post]
pub fn (mut app App) api_signup(mut ctx Context) vweb.Result {
	dump(ctx.form)

	user := User.new(
		ctx.form['name'],
		ctx.form['email'],
		ctx.form['password']
	) or {
		return ctx.server_error(err.msg())
	}

	app.sessions.save(mut ctx, user) or {
		return ctx.server_error(err.msg())
	}

	return ctx.redirect('/')
}

@['/api/signin'; post]
pub fn (mut app App) signin(mut ctx Context) vweb.Result {
	app.sessions.save(mut ctx, User{
		name: ''
		email: ''
		hashed_password: ''
	}) or { return ctx.server_error('Falha ao realizar login de usuário') }

	return ctx.redirect('/')
}

@['/api/signout'; post]
pub fn (mut app App) signout(mut ctx Context) vweb.Result {
	app.sessions.logout(mut ctx) or {
		return ctx.server_error('Falha ao realizar logout de usuário')
	}

	return ctx.redirect('/')
}
