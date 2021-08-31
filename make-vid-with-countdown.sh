#!/bin/bash

#youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' -o announcements ${1}
# comment the above out and just go straight from the mp4 if we need to get it somewhere besides youtube

rm list.txt

thingy=`ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 announcements.mp4`

duration=`echo ${thingy} | awk '{print ($0-int($0)>0)?int($0)+1:int($0)}'`

for i in $(seq 1 $((($1+$duration-1)/$duration)));
do
    echo "file 'announcements.mp4'" >> list.txt;
done

ffmpeg -f concat -i list.txt -c copy loop.mp4

ffmpeg -sseof -${1} -i loop.mp4 -c copy loop${1}.mp4

bash countdown-timer-from-video.sh loop${1}.mp4

rm announcements.mp4 list.txt loop.mp4 loop${1}.mp4
