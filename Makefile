all: dev

dev:
	@concurrently "npx tailwindcss -i ./src/styles.css -o ./assets/styles.css --watch" "v -o bin/src.exe -cg -d vweb_livereload watch run ./src"
