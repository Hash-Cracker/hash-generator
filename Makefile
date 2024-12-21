# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -O2 -std=c99
LDFLAGS = -lssl -lcrypto

# Output binary name
TARGET = hash_generator

# Source files
SRC = src/hash-gen.c

# Object files
OBJ = $(SRC:.c=.o)

# Installation directory (can be changed if needed)
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

# Default target to build the program
all: $(TARGET)

# Rule to build the target
$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) $(LDFLAGS)

# Rule to compile C source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up generated files
clean:
	rm -f $(OBJ) $(TARGET)

# Install the binary to the system
install: $(TARGET)
	sudo cp $(TARGET) $(BINDIR)
	sudo chmod +x $(BINDIR)/$(TARGET)
	@echo "Installed $(TARGET) to $(BINDIR)"

# Uninstall the binary from the system
uninstall:
	sudo rm -f $(BINDIR)/$(TARGET)
	@echo "Uninstalled $(TARGET) from $(BINDIR)"

# Run the program after building
run: $(TARGET)
	./$(TARGET)

# Help message
help:
	@echo "Makefile for hash generator in C"
	@echo "Usage:"
	@echo "  make        - Build the program"
	@echo "  make clean  - Remove object files and the binary"
	@echo "  make run    - Build the program and run it"
	@echo "  make install - Install the binary to /usr/local/bin"
	@echo "  make uninstall - Uninstall the binary from /usr/local/bin"
	@echo "  make help   - Display this help message"

