STGIT_WORKTREE ?= ../stgit
STGIT_DOC = $(STGIT_WORKTREE)/Documentation
MAN_DIR = content/man

.SHELLFLAGS += -e

STG_COMMANDS = $(shell cd $(STGIT_WORKTREE); cargo --quiet run completion list commands)
STG_COMMANDS_ADOC = $(patsubst %,$(MAN_DIR)/stg-%.adoc,$(STG_COMMANDS))
STG_COMMANDS_TXT = $(patsubst %,$(STGIT_DOC)/stg-%.txt,$(STG_COMMANDS))

.PHONY: sync
sync: clean-man command-list.txt $(STG_COMMANDS_ADOC) $(MAN_DIR)/stg.adoc content/changelog/_index.md

.PHONY: FORCE
FORCE:

.PHONY: clean-man
clean-man:
	$(RM) $(MAN_DIR)/*.adoc
	$(RM) txt-stamp

$(STG_COMMANDS_TXT) $(STGIT_DOC)/command-list.txt: txt-stamp

txt-stamp: FORCE
	$(QUIET)$(RM) txt-stamp-temp
	$(QUIET)touch txt-stamp-temp
	$(MAKE) -C $(STGIT_DOC)
	$(QUIET)mv txt-stamp-temp $@

$(MAN_DIR)/stg.adoc: $(STGIT_DOC)/stg.txt command-list.txt FORCE
	@echo "+++" > $@
	@echo "title = \"stg(1)\"" >> $@
	@echo "+++" >> $@
	@echo >> $@
	cat $< >> $@

$(MAN_DIR)/stg-%.adoc: $(STGIT_DOC)/stg-%.txt FORCE
	@echo "+++" > $@
	@echo "title = \"$(subst .adoc,,$(subst $(MAN_DIR)/,,$@))(1)\"" >> $@
	@echo "+++" >> $@
	@echo >> $@
	cat $< >> $@

command-list.txt: $(STGIT_DOC)/command-list.txt FORCE
	cp $< $@

content/changelog/_index.md: $(STGIT_WORKTREE)/CHANGELOG.md FORCE
	@echo "+++" > $@
	@echo "title = 'StGit Changelog'" >> $@
	@echo "+++" >> $@
	@echo >> $@
	cat $< >> $@
