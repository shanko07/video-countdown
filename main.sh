#!/bin/bash

# ${1} is the number of seconds
seconds=${1}
audio=${2}

bash make-vid-with-countdown.sh ${seconds}
echo ${audio}
ffmpeg -i ${seconds}-countdown-timer.mp4 -i ${audio} -shortest -af "afade=out:st=$(($seconds-2)):d=2" -c:v libx264 -crf 28 -preset ultrafast -map 1:a:0 -map 0:v:0 fade_vid.mp4
