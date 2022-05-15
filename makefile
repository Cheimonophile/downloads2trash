# Must also enable full disk access for /bin/sh in System Preferences > Privacy 
# > Full Disk Access

AGENTS=~/Library/LaunchAgents
PLIST=benrmclemore.downloads2trash.plist

all: install

install: $(AGENTS)/$(PLIST)
	launchctl unload $(AGENTS)/$(PLIST)
	launchctl load $(AGENTS)/$(PLIST)

$(AGENTS)/$(PLIST): $(PLIST) makefile
	sed 's+@DIR+$(shell pwd)+g' "$(PLIST)" >$(AGENTS)/$(PLIST)

uninstall:
	launchctl unload $(AGENTS)/$(PLIST)
	sudo rm $(AGENTS)/$(PLIST) 