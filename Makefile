# change these to reflect your Lua installation
LUA= /usr
LUAINC= $(LUA)/include
LUALIB= $(LUA)/lib
LUABIN= $(LUA)/bin

LIBXML2=/usr
LIBXML2INC=$(LIBXML2)/include/libxml2
LIBXML2LIB=$(LIBXML2)/lib

# no need to change anything below here
CFLAGS= $(INCS) $(DEFS) $(WARN) -O2
WARN= -Wall
INCS= -I$(LUAINC) -I$(LIBXML2INC)
LIBS= -lxml2 -L$(LIBXML2LIB)
LIBFLAG= -shared

OBJS= xmlreader.o error.o

SOS= xmlreader.so

all: $(SOS)

$(SOS): $(OBJS)
	$(CC) -o $@ $(LIBFLAG) $(OBJS) $(LIBS)

.PHONY: clean doc
clean:
	rm -f $(OBJS) $(SOS) core core.* a.out

doc:
	lua doc/extract_doc.lua xmlreader.c > doc/xmlreader.html

tar: clean
	git archive --format=tar --prefix=lua-xmlreader-$(VERSION)/ v$(VERSION) | gzip > lua-xmlreader-$(VERSION).tar.gz