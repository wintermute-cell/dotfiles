# Scripts
This is a collection of various smaller scripts.

-   yt-album.sh: Given a youtube url, downloads and splits the video as mp3 chapters.
    Requires:
    - `yt-dlp`
    - `python3`
    - `beets with config`:
        ```
        plugins: fromfilename fetchart embedart discogs
        directory: ~/Music
        library: ~/.cache/beet/musiclibrary.db
        ```

## Installation
Create a new dir called `.scripts` in your $HOME.

Run `git clone https://github.com/wintermute-cell/scripts.git .` (with the dot at the end)

Create aliases like `alias fmux='$HOME/.scripts/fmux/tmux_session_fzf.sh`
