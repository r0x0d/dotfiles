# Symlink the dotfiles into $HOME. Plain ln -s, works on Linux and macOS.
#
# The first Neovim start after a fresh `make install` installs the plugins
# by itself: vim.pack reads config/nvim/nvim-pack-lock.json and clones the
# pinned revisions.

REPO := $(CURDIR)

.PHONY: install uninstall
.DEFAULT_GOAL := install

install:
	mkdir -p $(HOME)/.config
	ln -sfn $(REPO)/config/nvim $(HOME)/.config/nvim
	ln -sfn $(REPO)/vim/.vimrc  $(HOME)/.vimrc

uninstall:
	rm -f $(HOME)/.config/nvim $(HOME)/.vimrc
