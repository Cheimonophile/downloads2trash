# arguments
NAME=downloads2trash
EXE=downloads2trash.sh

# constants
AGENTS=~/Library/LaunchAgents
USER=$(shell whoami)
LABEL=$(USER).$(NAME)
PLIST=$(LABEL).plist
DIR=$(shell pwd)

all: install

install: $(AGENTS)/$(PLIST) run
	rm logs.log || True
	launchctl unload $(AGENTS)/$(PLIST)
	launchctl load $(AGENTS)/$(PLIST)

$(AGENTS)/$(PLIST): info.plist
	sed 's+@DIR+$(DIR)+g; s+@LABEL+$(LABEL)+g; s+@EXE+$(EXE)+g' info.plist >$(AGENTS)/$(PLIST)

run: run.c
	gcc -o run run.c

uninstall:
	launchctl unload $(AGENTS)/$(PLIST)
	sudo rm $(AGENTS)/$(PLIST) 