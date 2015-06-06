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
.PHONY: $(symlinks) i3

install: $(symlinks) font-awesome i3 set-user-directories

$(symlinks):
	test -e $(CURDIR)/$@ && ln $(LN_FLAGS) $(CURDIR)/$@ ~/.$@

# this needs xdg-user-dirs installed
set-user-directories:
	xdg-user-dirs-update --set DOWNLOAD ~/downloads && \
	xdg-user-dirs-update --set DESKTOP ~/

i3:
	mkdir -p ~/.i3 && ln $(LN_FLAGS) $(CURDIR)/i3/config ~/.i3/config

font-awesome:
	mkdir -p ~/.local/share/fonts && \
	ln $(LN_FLAGS) $(CURDIR)/fontawesome-webfont.ttf \
		~/.local/share/fonts/fontawesome-webfont.ttf && \
	fc-cache -fv > /dev/null 2>&1

check-dead:
	find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -print

clean-dead:
	find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -delete

update:
	git pull --rebase
