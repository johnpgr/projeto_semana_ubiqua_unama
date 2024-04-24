module main

import x.vweb

pub fn (app &App) index(mut ctx Context) vweb.Result {
	page_title := 'Titulo'
	if user := ctx.session_data {
		eprintln(user)
	} else {
		eprintln('not authenticated')
	}

	return $vweb.html()
}

pub fn (app &App) signup(mut ctx Context) vweb.Result {
	page_title := 'Cadastro'

	if user := ctx.session_data {
		return ctx.redirect('/')
	} else {
		return $vweb.html()
	}
}
