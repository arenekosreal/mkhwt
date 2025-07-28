function __mkhwt_unlock -a theme_root -a unlock
    mkdir -p "$theme_root/unlock"
    if test -z "$unlock"
        __mkhwt_log info "Generating dummy unlock directory..."
        begin
            echo '<?xml version="1.0" encoding="UTF-8" ?>'
            echo '<HwTheme>'
            echo '  <item style="magazine" />'
            echo '</HwTheme>'
        end >"$theme_root/unlock/theme.xml"
    else if not test -f "$unlock/theme.xml"
        __mkhwt_log error "`$unlock` is not a valid unlock directory."
        return 1
    else
        cp -r "$unlock/." "$theme_root/unlock"
    end
end
