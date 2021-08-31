#!/bin/bash

# ${1} is the number of seconds
seconds=${1}

bash make-vid-with-countdown.sh ${seconds}
ffmpeg -i ${seconds}-countdown-timer.mp4 -i looped_audio.mp3 -shortest -af "afade=out:st=$(($seconds-2)):d=2" -c:v libx264 -crf 28 -preset ultrafast fade_vid.mp4
