.PHONY: clean install uninstall

JAVA_PREFIX ?= /trusted/java
MONO_PREFIX ?= /trusted/mono
MONO_CFLAGS += -D_REENTRANT -I$(MONO_PREFIX)/include/mono-2.0
MONO_LIBS   += -L$(MONO_PREFIX)/lib -lmono-2.0 -lm -lrt -ldl -lpthread
CFLAGS += -O3 -Wall -Wextra -Werror=implicit-function-declaration -Werror=return-type

bin/cs_exec.exe: cs_exec/Main.cs
	@mkdir -p bin
	mcs -debug+ $^ -out:$@

bin/clrexec: cs_exec/main.c
	@mkdir -p bin
	@# $(CC) $(CFLAGS) $^ $(shell pkg-config --cflags --libs mono-2) -o $@
	$(CC) $(CFLAGS) $^ '-DMONO_PREFIX="$(MONO_PREFIX)"' -Wl,-rpath=$(MONO_PREFIX)/lib $(MONO_CFLAGS) $(MONO_LIBS) -o $@

clean:
	rm -rf bin

install:
	@mkdir -p $(DESTDIR)$(JAVA_PREFIX)/jre/lib/security
	install -pm644 java_policies/lerna.policy $(DESTDIR)$(JAVA_PREFIX)/jre/lib/security/

uninstall:
	rm -f $(DESTDIR)$(JAVA_PREFIX)/jre/lib/security/lerna.policy
