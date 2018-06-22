#!/bin/bash
#Tool to process Looney Tunes Episodes
#By: Dan Walker (2018)

#Root List of ALL Looney Tunes Episodes
EPISODE_LIST=LooneyTunesEpisodes.csv
#User Input needs to match disc title and file name
DISC=$1
IFS=$'\n'
PROCESS=$2


#Let's first create our manifest
if [ ! -f "$DISC-manifest.txt" ]; then
ls | grep "$DISC-[0-9][0-9][0-9]" > "$DISC-manifest.txt"
else
        echo "Manifest already exists! Not creaeting it again."
fi

while read -r line
do
NUM=$(echo "$line" | awk -F'[-]' '{print $2}' | sed 's/\.[^.]*$//' | sed 's/^0*//')
TITLE=$(sed "${NUM}q;d" "$DISC.txt")
#EP_NUM=$(cat $EPISODE_LIST | grep -i "$TITLE" | sed 's/,.*//')
EP_NUM=$(grep -i "$TITLE" $EPISODE_LIST | sed 's/,.*//')
if [[ -z $EP_NUM ]]; then
        $RANDOM=$(1 + RANDOM % 10)
        EP_NUM="$RANDOM-NEEDS-FIXING"
fi
if [ $PROCESS == "1" ]; then
        echo "Process level 1, all systems go!"
        echo "Renaming: $line to Looney.Tunes.$EP_NUM.m4v"
        mv "$line" "Looney.Tunes.$EP_NUM.m4v"
else
        echo "Process level 0, Dry run only!"
        echo "Renaming: $line to Looney.Tunes.$EP_NUM.m4v"
        #mv "$line" "Looney.Tunes.$EP_NUM.m4v"
fi
done < "$DISC"-manifest.txt
