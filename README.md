# Dotfiles

Personal settings and configurations.
Management is done with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

- `stow` must be installed.

## Usage

Clone this repo in `~` and create all symlinks.
This will put all the config files in the appropriate locations.
```console
cd ~/dotfiles
stow .
sudo stow etc -t /etc
```

## Acknowledgments
A good chunk of my Neovim configuration came from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

The contents of `.luarc.json` for the Neovim config folder were inspired by [this video](https://www.youtube.com/watch?v=UE6XQTAxwE0) from Marco Peluso.

My WezTerm color configuration is based on [wezterm-canonical-solarized](https://github.com/gfguthrie/wezterm-canonical-solarized).

My KDE Plasma color scheme is a near exact copy of [kde-plasma-solarized](https://github.com/ret2src/kde-plasma-solarized).
