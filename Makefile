SRCDIR=content
STATICDIR=static
DESTDIR=public
SOURCES := $(shell find $(SRCDIR) -type f -name '*.md')
TARGETS := $(patsubst $(SRCDIR)/%.md,$(DESTDIR)/%.html,$(SOURCES))

.PHONY: all
all: build serve

.PHONY: clean
clean:
	rm -rf $(DESTDIR)/*

.PHONY: serve
serve:
	python -m http.server --directory $(DESTDIR)

.PHONY: build
build: copy-static $(TARGETS)

.PHONY: copy-static
copy-static: $(STATICDIR) $(DESTDIR)
	cp -Rf $(STATICDIR)/* $(DESTDIR)/

public:
	mkdir -p public

$(TARGETS): $(SOURCES) template.html5 $(DESTDIR)
	pandoc \
	--to html5 \
	--template=template \
	--css="./style.css" \
	--output "$@" \
	"$<"
