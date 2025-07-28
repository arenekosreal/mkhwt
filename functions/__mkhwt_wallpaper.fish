function __mkhwt_wallpaper -a theme_root -a wallpaper
    if test -z "$wallpaper"
        __mkhwt_log info "No wallpaper provided, skip adding..."
    else if not test -d "$wallpaper"
        __mkhwt_log error "`$wallpaper` is not a valid wallpaper directory."
        return 1
    else
        mkdir -p "$theme_root/wallpaper"
        cp -r "$wallpaper/." "$theme_root/wallpaper"
    end
end
