CURDIR ?= $(.CURDIR)
LN_FLAGS = -sfn
symlinks = vimrc \
		   bashrc \
		   i3status.conf \
		   Xdefaults \
		   xinitrc \
		   fonts.conf \
		   gdbinit

# makes sure make will always make file
.PHONY: $(symlinks)

all: install set-downloads-directory

install: $(symlinks)

$(symlinks):
	test -e $(CURDIR)/$@ && ln $(LN_FLAGS) $(CURDIR)/$@ ~/.$@

# this needs xdg-user-dirs installed
set-downloads-directory:
	xdg-user-dirs-update --set DOWNLOAD ~/downloads

check-dead:
	find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -print

clean-dead:
	find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -delete

update:
	git pull --rebase
