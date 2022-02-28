# Must also enable full disk access for /bin/sh in System Preferences > Privacy 
# > Full Disk Access

SERVICES=/usr/local/bin
AGENTS=~/Library/LaunchAgents
PLIST=community.benrmclemore.downloads2trash.plist
SCRIPT=community.benrmclemore.downloads2trash.sh

all: install

install: $(SERVICES)/$(SCRIPT) $(AGENTS)/$(PLIST)
	launchctl unload $(AGENTS)/$(PLIST)
	launchctl load $(AGENTS)/$(PLIST)

$(SERVICES)/$(SCRIPT): $(SCRIPT)
	mkdir -p $(SERVICES)
	sudo cp $(SCRIPT) $(SERVICES)/$(SCRIPT)
	sudo chmod a+s $(SERVICES)/$(SCRIPT)

$(AGENTS)/$(PLIST): $(PLIST)
	cp $(PLIST) $(AGENTS)/$(PLIST)

uninstall:
	launchctl unload $(AGENTS)/$(PLIST)
	sudo rm $(SERVICES)/$(SCRIPT)
	sudo rm $(AGENTS)/$(PLIST)