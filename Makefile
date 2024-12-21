CC = gcc
CFLAGS = -Wall -Wextra -O2 -std=c99
LDFLAGS = -lssl -lcrypto

TARGET = hash_generator

SRC = src/hash-gen.c

OBJ = $(SRC:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(TARGET)

run: $(TARGET)
	./$(TARGET)

help:
	@echo "Makefile for hash generator in C"
	@echo "Usage:"
	@echo "  make        - Build the program"
	@echo "  make clean  - Remove object files and the binary"
	@echo "  make run    - Build the program and run it"
	@echo "  make help   - Display this help message"

