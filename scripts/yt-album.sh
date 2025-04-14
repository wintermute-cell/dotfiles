#!/usr/bin/env bash

read -p "url/id: " url_id

yt-dlp -x --audio-format mp3 --split-chapters -P "$HOME/Downloads/yt-album/" -o "/tmp/yt-album/original_file_%(title)s%(id)s.%(ext)s" -o "chapter:%(section_title)s.%(ext)s" $url_id

beet import --autotag --move --timid --group-albums ~/Downloads/yt-album
