CC = gcc
CFLAGS = -Wall -Wextra -O2 -std=c99
LDFLAGS = -lssl -lcrypto

TARGET = hash-gen

SRC = src/hash-gen.c

OBJ = $(SRC:.c=.o)

PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(TARGET)

install: $(TARGET)
	sudo cp $(TARGET) $(BINDIR)
	sudo chmod +x $(BINDIR)/$(TARGET)
	@echo "Installed $(TARGET) to $(BINDIR)"

uninstall:
	sudo rm -f $(BINDIR)/$(TARGET)
	@echo "Uninstalled $(TARGET) from $(BINDIR)"

run: $(TARGET)
	./$(TARGET)

help:
	@echo "Makefile for hash generator in C"
	@echo "Usage:"
	@echo "  make        - Build the program"
	@echo "  make clean  - Remove object files and the binary"
	@echo "  make run    - Build the program and run it"
	@echo "  make install - Install the binary to /usr/local/bin"
	@echo "  make uninstall - Uninstall the binary from /usr/local/bin"
	@echo "  make help   - Display this help message"

