# see cgo.c for copyright and license details
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

CPPFLAGS = -D_FORTIFY_SOURCE=2 -D_DEFAULT_SOURCE -D_BSD_SOURCE \
        -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L
CFLAGS = -Wall -Wextra -Wformat-security -Wpointer-arith \
	-Winit-self -fno-exceptions -fstack-protector-strong \
	--param=ssp-buffer-size=4 -std=c99 -Wpedantic -pedantic \
	-pipe -O2 -fpie -pie -Wl,--no-undefined -Wl,--build-id=sha1 \
	-Wl,-z,relro -Wl,-z,now -Wl,-O1a -s

CC ?= cc

SRC = cgo.c
BIN = cgo
MAN = cgo.1

all: $(BIN)
	
$(BIN): $(SRC)

clean:
	rm -f $(BIN)

install:
	@echo "Installing..."
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp -f $(BIN) $(DESTDIR)$(PREFIX)/bin
	@cp -f $(MAN) $(MANPREFIX)/man1

uninstall:
	@echo "Uninstalling..."
	@rm -f $(DESTDIR)$(PREFIX)/bin/$(BIN)
	@rm -f $(MANPREFIX)/man1/$(MAN)

.PHONY: clean install uninstall all
