CC := gcc
CFLAGS := -O2 -static

# Targets
TARGETS := ao argv

all: $(TARGETS)

ao: ao.c
	$(CC) $(CFLAGS) -o $@ $<

argv: argv.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f $(TARGETS)
