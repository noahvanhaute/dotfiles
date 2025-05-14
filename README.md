# Dotfiles

Personal settings and configurations.
Management is done with [GNU Stow](https://www.gnu.org/software/stow/).

## Usage

Simply clone this repo in `~` and run `stow .`.
This will put all the config files in the appropriate location.

Some programs don't store their configuration in `~` but in `\etc`.
These will not be stowed when running `stow .`, instead use `sudo stow etc -t /etc`.

## Acknowledgements
A good chunk of my Neovim configuration came from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
