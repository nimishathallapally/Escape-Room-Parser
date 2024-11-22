# Directories
SRC_DIR = src
BUILD_DIR = build

# Files
BISON_FILE = $(SRC_DIR)/game.y
LEX_FILE = $(SRC_DIR)/game.l
BISON_C = $(BUILD_DIR)/game.tab.c
BISON_H = $(BUILD_DIR)/game.tab.h
LEX_C = $(BUILD_DIR)/lex.yy.c
EXECUTABLE = game

# Compiler and flags
CC = gcc
BISON = bison
FLEX = flex
CFLAGS = -o

# Targets
all: $(BUILD_DIR) $(EXECUTABLE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BISON_C) $(BISON_H): $(BISON_FILE)
	$(BISON) -vd -o $(BUILD_DIR)/game.tab.c $(BISON_FILE)

$(LEX_C): $(LEX_FILE)
	$(FLEX) -o $(BUILD_DIR)/lex.yy.c $(LEX_FILE)

$(EXECUTABLE): $(BISON_C) $(LEX_C)
	$(CC) $(BISON_C) $(LEX_C) -o $(EXECUTABLE)

clean:
	rm -rf $(BUILD_DIR) $(EXECUTABLE)

# Convenience target to run
run: $(EXECUTABLE)
	./$(EXECUTABLE)
