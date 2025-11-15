CC := gcc
CFLAGS := -O2 -static

BINARIES := ao argv
SRC := ao.c argv.c

# --------------------------
# Targets
# --------------------------
all: $(BINARIES)

ao: ao.c
	$(CC) $(CFLAGS) -o $@ $<

argv: argv.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	@rm -f $(BINARIES)

# --------------------------
# Test suite
# --------------------------
check: all
	@echo "Running tests..."

	@printf "Test 1: ./ao (expects exit 1)... "
	@./ao >/dev/null 2>&1 && echo FAIL || echo OK

	@printf "Test 2: ./argv (expects 'argv[0] = ./argv')... "
	@./argv | grep -q "argv\[0] = ./argv" && echo OK || echo FAIL

	@printf "Test 3: ./argv something something 123... "
	@./argv something something 123 | grep -q "argv\[3] = 123" && echo OK || echo FAIL

	@printf "Test 4: ./ao ./argv hi (expects argv[0] = hi)... "
	@./ao ./argv hi | grep -q "argv\[0] = hi" && echo OK || echo FAIL

	@echo "Done."

# --------------------------
# Distribution
# --------------------------
DISTFILE := ao.tar.gz

dist:
	@echo "Creating $(DISTFILE)"
	@mkdir -p $(PACKAGE)-$(VERSION)
	@cp -a $(SRC) Makefile $(PACKAGE)-$(VERSION)/
	@tar -czf $(DISTFILE) $(PACKAGE)-$(VERSION)
	@rm -rf $(PACKAGE)-$(VERSION)
	@echo "Created $(DISTFILE)"

# --------------------------
# Declare phony targets
# --------------------------
.PHONY: all clean check dist
