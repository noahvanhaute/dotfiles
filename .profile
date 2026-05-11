test -z "$PROFILEREAD" && . /etc/profile || true

if [ -d /mnt/c/Windows ]; then
	PATH="$PATH:/mnt/c/Users/*/scoop/apps/win32yank/current"
	PATH="$PATH:/mnt/c/Program Files/Mozilla Firefox"

	export BROWSER=firefox.exe
fi

export TEXMFHOME=$XDG_DATA_HOME/texmf

PATH="$PATH:$HOME/.opt/texlive/current/bin/x86_64-linux"
