TARGET  = sbreload
OUTDIR ?= .
SRC     = $(wildcard *.c) $(wildcard *.m)

CC      = xcrun -sdk iphoneos gcc -arch arm64 -arch arm64e
LDID    = ldid
CFLAGS  = -framework Foundation

.PHONY: all install clean

all: $(TARGET)


$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $@ $^
	$(LDID) -S $@


clean:
	rm sbreload
