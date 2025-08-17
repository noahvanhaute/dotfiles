# WSL specific settings
if [ -d /mnt/c/Windows ]; then
	export PATH="$PATH:/mnt/c/Users/noahv/scoop/apps/win32yank/current"
	export PATH="$PATH:/mnt/c/Program Files/Mozilla Firefox"

	export BROWSER=firefox.exe
fi
