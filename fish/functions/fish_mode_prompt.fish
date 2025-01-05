function fish_mode_prompt
    # This is set empty, since the mode prompt is done custom in fish_prompt.
    # This must be set as a separate function file, so it loads before vi mode
    # loads and prints the first mode prompt in an incorrect place.
end
