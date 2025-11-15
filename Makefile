CC := gcc
CFLAGS := -O2 -static
all: ao argv
ao: ao.c
	$(CC) $(CFLAGS) -o $@ $<
argv: argv.c
	$(CC) $(CFLAGS) -o $@ $<
clean:
	rm -f ao argv

