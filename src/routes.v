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
