#!/usr/bin/env bash
set -e

# Ensure required tools are available
for cmd in ffmpeg amixer xdpyinfo; do
  command -v "$cmd" >/dev/null || { notify-send "Missing dependency: $cmd"; exit 1; }
done

record() {
  amixer set Capture toggle

  RES="$(xdpyinfo | awk '/dimensions/{print $2}')"
  TIMESTAMP="$(date '+%a__%b%d__%H_%M_%S')"
  OUTPUT="$HOME/Videos/recording_$TIMESTAMP.mkv"

  ffmpeg \
    -f x11grab -s "$RES" -r 30 -i :0.0 \
    -f v4l2 -i /dev/video0 \
    -f alsa -i default \
    -filter_complex "\
      [1:v]scale=iw*0.5:ih*0.5,scale=iw*0.5:ih*0.5,format=rgba,\
      drawbox=x=0:y=0:w=iw:h=ih:color=white@0.4:t=4,\
      geq=r='r(X,Y)':g='g(X,Y)':b='b(X,Y)':a='if(gt(pow(X-(W/2),2)+pow(Y-(H/2),2),pow(min(W,H)/2,2)),0,255)'[cam];\
      [0:v][cam]overlay=W-w-10:H-h-10" \
    -c:v libx264 -preset ultrafast -qp 20 \
    -af "afftdn=nf=-75" \
    "$OUTPUT" &

  echo $! > /tmp/recpid

  notify-send -t 1000 "🔴 Recording started" "Mic & webcam on.\nSaving to:\n$OUTPUT"
}

end() {
  kill -15 "$(cat /tmp/recpid)" 2>/dev/null || true
  rm -f /tmp/recpid
  amixer set Capture toggle
  notify-send -t 1000 "⏹️ Recording stopped" "Mic & webcam off."
}

# Toggle recording
if [[ -f /tmp/recpid ]]; then
  end
else
  record
fi

