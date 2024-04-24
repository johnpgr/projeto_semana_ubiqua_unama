include .env
export

PROJECT_NAME="projeto_semana_ubiqua_unama"
BIN_DIR=bin
SRC_DIR=src
TARGET=$(BIN_DIR)/$(PROJECT_NAME)

all: dev

dev: $(TARGET)
	@concurrently "npx tailwindcss -i ./src/templates/styles.css -o ./assets/styles.css --watch" "v -o $(TARGET) -cg -d vweb_livereload watch run ./$(SRC_DIR)"

$(TARGET):
	@mkdir -p $(BIN_DIR)
