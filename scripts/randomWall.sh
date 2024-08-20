#!/bin/bash

# Define the directory containing wallpapers
directory=~/Pictures/wallpapers
# Define a file to keep track of used wallpapers
used_wallpapers_file=~/Pictures/wallpapers/.used_wallpapers.txt

# Create the used wallpapers file if it doesn't exist
if [ ! -f "$used_wallpapers_file" ]; then
    touch "$used_wallpapers_file"
fi

# Check if the directory exists
if [ -d "$directory" ]; then
    # Get a list of all wallpapers
    all_wallpapers=($(ls $directory/*.jpg $directory/*.png))

    # Filter out wallpapers that have already been used
    available_wallpapers=()
    for wallpaper in "${all_wallpapers[@]}"; do
        if ! grep -qx "$wallpaper" "$used_wallpapers_file"; then
            available_wallpapers+=("$wallpaper")
        fi
    done

    # If there are available wallpapers, select one randomly
    if [ ${#available_wallpapers[@]} -gt 0 ]; then
        random_background=$(printf "%s\n" "${available_wallpapers[@]}" | shuf -n 1)

        # Unload and set the new wallpaper
        # hyprctl hyprpaper unload all && sleep 1 &&
        # hyprctl hyprpaper preload "$random_background" &&
        # hyprctl hyprpaper wallpaper "VGA-1, $random_background" &&
        echo "Setting wallpaper to $random_background" 
        swww img "$random_background" --transition-type outer &
        wal -i "$random_background"
        pkill waybar && waybar &

        # Add the selected wallpaper to the used file
        echo "$random_background" >> "$used_wallpapers_file"
    else
        # Reset the used wallpapers file
        > "$used_wallpapers_file"
    fi
else
    echo "Directory $directory does not exist."
fi
