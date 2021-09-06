SOURCES := $(shell find src -type f -name '*.md')
TARGETS := $(patsubst src/%.md,public/%.html,$(SOURCES))

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	rm -f public/*.html

.PHONY: serve
serve:
	python -m http.server --directory public

public/%.html: src/%.md template.html5 public/style.css
	pandoc \
	--to html5 \
	--template=template \
	--css="style.css" \
	--output "$@" \
	"$<"
