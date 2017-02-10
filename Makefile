.PHONY: all install uninstall

JAVA_PREFIX ?= /trusted/java

all: # No-op for plain `make`.

install:
	@mkdir -p $(DESTDIR)$(JAVA_PREFIX)/jre/lib/security
	install -pm644 java_policies/lerna.policy $(DESTDIR)$(JAVA_PREFIX)/jre/lib/security/

uninstall:
	rm -f $(DESTDIR)$(JAVA_PREFIX)/jre/lib/security/lerna.policy
