PYTHON ?= python
STGIT_WORKTREE ?= ../stgit
STGIT_DOC = $(STGIT_WORKTREE)/Documentation
MAN_DIR = $(PWD)/pages/man

.PHONY: build
build: local-asciidoc
	nikola build

.PHONY: local-asciidoc
local-asciidoc: stgit-html asciidoc.conf command-list.txt
	mkdir -p $(MAN_DIR)
	cp $(STGIT_DOC)/tutorial.txt $(MAN_DIR)
	cp $(STGIT_DOC)/stg*.txt $(MAN_DIR)

.PHONY: stgit-html
stgit-html:
	$(MAKE) -C $(STGIT_WORKTREE) PYTHON=$(PYTHON) build
	$(MAKE) -C $(STGIT_DOC) PYTHON=$(PYTHON) html

asciidoc.conf:
	cp $(STGIT_DOC)/asciidoc.conf .

command-list.txt: stgit-html
	cp $(STGIT_DOC)/command-list.txt .

.PHONY: clean
clean:
	$(RM) -r $(MAN_DIR)
	$(RM) -r output/man/*
	$(RM) asciidoc.conf
	$(RM) command-list.txt

.PHONY: deploy
deploy: build
	nikola github_deploy

# ASCIIDOC_HTML = "html5 -afooter-style=none -anotitle=1"
# ASCIIDOC_HTML = "html5 -s"
# ASCIIDOC_HTML = "html5"
#
# .PHONY: stgit-doc
# stgit-doc: stgit-html
# 	$(MAKE) -C $(STGIT_DOC) ASCIIDOC_HTML=$(ASCIIDOC_HTML) htmldir=$(MAN_DIR) install-html
