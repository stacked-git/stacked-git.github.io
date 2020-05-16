PYTHON ?= python
STGIT_WORKTREE ?= ../stgit
BUILD_PY = $(STGIT_WORKTREE)/build.py
STGIT_DOC = $(STGIT_WORKTREE)/Documentation
MAN_DIR = content/man

STG_COMMANDS = $(shell $(PYTHON) $(BUILD_PY) --commands)
STG_COMMANDS_ADOC = $(patsubst %,$(MAN_DIR)/stg-%.adoc,$(STG_COMMANDS))

.PHONY: sync
sync: clean-man command-list.txt $(STG_COMMANDS_ADOC) $(MAN_DIR)/stg.adoc content/changelog/_index.md

.PHONY: FORCE
FORCE:

.PHONY: clean-man
clean-man:
	$(RM) $(MAN_DIR)/*.adoc

$(MAN_DIR)/stg.adoc: $(STGIT_DOC)/stg.txt FORCE
	@echo "+++" > $@
	@echo "title = \"stg(1)\"" >> $@
	@echo "+++" >> $@
	@echo >> $@
	cat $< >> $@

$(MAN_DIR)/stg-%.adoc: FORCE
	@echo "+++" > $@
	@echo "title = \"$(subst .adoc,,$(subst $(MAN_DIR)/,,$@))(1)\"" >> $@
	@echo "+++" >> $@
	@echo >> $@
	$(PYTHON) $(BUILD_PY) --asciidoc $(basename $(subst $(MAN_DIR)/stg-,,$@)) >> $@

command-list.txt: FORCE
	$(PYTHON) $(BUILD_PY) --cmd-list > $@

content/changelog/_index.md: $(STGIT_WORKTREE)/CHANGELOG.md FORCE
	@echo "+++" > $@
	@echo "title = 'StGit Changelog'" >> $@
	@echo "+++" >> $@
	@echo >> $@
	cat $< >> $@
