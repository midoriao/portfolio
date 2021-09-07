SRCDIR=content
STATICDIR=static
DESTDIR=public
GIT_USERNAME="Sota Sato"
GIT_EMAIL="sotasato@nii.ac.jp"
DEPLOY_REPO:=$(shell git config --get remote.deploy.url)
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

.PHONY: deploy
deploy:
	@echo "? remote repo: <$(DEPLOY_REPO)>"
	rm -rf $(DESTDIR)
	git clone $(DEPLOY_REPO) $(DESTDIR) --depth 1 --no-checkout -q
	make build > /dev/null
	@cd $(DESTDIR) \
	&& git config user.name "$(GIT_USERNAME)" \
	&& git config user.email "$(GIT_EMAIL)" \
	&& git add . \
	&& git checkout -q HEAD README.md \
	&& git status \
	&& git commit -m "Update" \
	&& git push

public:
	mkdir -p public

$(TARGETS): $(SOURCES) template.html5 $(DESTDIR)
	pandoc \
	--to html5 \
	--template=template \
	--css="./style.css" \
	-M date:"$(shell date "+%Y-%m-%d")" \
	-M year:"$(shell date "+%Y")" \
	--output "$@" \
	"$<"

