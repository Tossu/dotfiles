CURDIR ?= $(.CURDIR)
LN_FLAGS = -sfn
files = zshrc \
		   bashrc \
		   bash_profile \
		   i3status.conf \
		   Xdefaults \
		   xinitrc \
		   fonts.conf \
		   gdbinit \
		   dircolors
scripts = font-awesome \
		  i3 \
		  set-user-directories \
		  install-zplug \
		  nvim

# makes sure make will always make file
.PHONY: $(files) $(scripts)

install: $(files) $(scripts)

$(files):
	test -e $(CURDIR)/$@ && ln $(LN_FLAGS) $(CURDIR)/$@ ~/.$@

nvim:
	ln $(LN_FLAGS) $(CURDIR)/nvim/ \
		~/.config/

install-zplug:
	git clone https://github.com/zplug/zplug ~/.zplug

# this needs xdg-user-dirs installed
set-user-directories:
	xdg-user-dirs-update --set DOWNLOAD ~/downloads && \
	xdg-user-dirs-update --set DESKTOP ~/

i3:
	mkdir -p ~/.i3 && ln $(LN_FLAGS) $(CURDIR)/i3/config ~/.i3/config

font-awesome:
	mkdir -p ~/.fonts && \
	ln $(LN_FLAGS) $(CURDIR)/fonts/fontawesome-webfont.ttf \
		~/.fonts/fontawesome-webfont.ttf && \
	fc-cache -fv > /dev/null 2>&1
