# Dotfiles
Personal settings and configurations.
Management is done with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites
- `stow` must be installed.

## Usage
Clone this repo in `~` and create all symlinks.
This will put all the config files in the appropriate locations.
> [!WARNING]
> This will overwrite existing configs, you can `git status` or `git diff` before executing the last command to see what will be overwritten.
```console
cd ~/dotfiles
stow --adopt .
sudo stow etc -t /etc
git reset --hard
```

## Acknowledgments
My Python compiler plugin came from siho's answer on [this Stack Exchange question](https://vi.stackexchange.com/questions/5110/quickfix-support-for-python-tracebacks).

My implementation of [Selenized Black](https://github.com/jan-warchol/selenized/blob/master/the-values.md#selenized-black) used [lucaaf3's implementation](https://github.com/lucaaf3/selenized-black.nvim) as a starting point.

The contents of `.luarc.json` for the Neovim config folder were inspired by [this video](https://www.youtube.com/watch?v=UE6XQTAxwE0) from Marco Peluso.
