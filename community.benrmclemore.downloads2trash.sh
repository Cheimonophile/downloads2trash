#!/bin/sh -e

# Constants
DOWNLOADS=~/Downloads
DS_STORE=.DS_Store
TRASH=~/.Trash

# Echo the date
echo "--- $(date)"

# mdfind -ctime +7
find ${DOWNLOADS} -ctime +7 -depth 1 | while read NAME
do
  # skip if is downloads
  if [[ ${DOWNLOADS} == ${NAME} ]]
  then
    continue
  fi

  # init new name
  BASENAME="${NAME##*/}"
  NEW_NAME="${TRASH}/${BASENAME}"

  # make sure it isn't DS_Store
  if [[ ${BASENAME} == ${DS_STORE} ]]
  then
    continue
  fi

  # make sure name isn't taken
  I=1
  while [ -f "$NEW_NAME" ] || [ -d "$NEW_NAME" ]
  do
    NEW_NAME="$TRASH/($I) $BASENAME"
    I=$(($I+1))
  done

  # move the file
  mv "$NAME" "$NEW_NAME"
  echo "mv \"$NAME\" \"$NEW_NAME\""
done