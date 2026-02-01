test -z "$PROFILEREAD" && . /etc/profile || true

if [ -d /mnt/c/Windows ]; then
	PATH="$PATH:/mnt/c/Users/*/scoop/apps/win32yank/current"
	PATH="$PATH:/mnt/c/Program Files/Mozilla Firefox"

	export BROWSER=firefox.exe
fi

PATH="$PATH:$HOME/.opt/texlive/current/bin/x86_64-linux"
