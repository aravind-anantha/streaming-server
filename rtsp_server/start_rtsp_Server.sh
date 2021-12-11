#!/bin/sh

port=8554
while [ $# -gt 0 ]; do
  case "$1" in
    -p|-port|--port)
      port="$2"
      ;;
    -a|-arg_1|--arg_1)
      arg_1="$2"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument.*\n"
      printf "***************************\n"
      exit 1
  esac
  shift
  shift
done

echo "Starting rtsp server on port: $port\n"

# Very basic vlc rtsp server.
#TODO: Explore config options

libcamera-vid -t 0 --inline -n -o - | cvlc - --sout "#transcode{acodec=none}:rtp{dst=0.0.0.0,port=$port,sdp=rtsp://:$port/mocha}" :demux=h264
