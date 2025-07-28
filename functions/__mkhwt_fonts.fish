function __mkhwt_fonts -a theme_root -a fonts
    mkdir -p "$theme_root/fonts"
    if not test -d "$fonts"
        __mkhwt_log error "`$fonts` is not a valid fonts directory."
        return 1
    end
    cp -r "$fonts/." "$theme_root/fonts"
end
