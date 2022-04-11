#!/bin/bash
until pgrep -x "csgo_linux64" > /dev/null; do
    echo "Starting CSGO"
    steam steam://rungameid/730 &
    sleep 30
done
echo "should be started?"   
