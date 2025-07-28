function __mkhwt_icons -a theme_root -a temp_dir -a icons -a icon_pack -a icon_map
    mkdir -p "$temp_dir/icons"
    if test -n "$icon_pack"
        __mkhwt_log info "Adding icons from icon pack..."
        __mkhwt_icon-pack "$icon_pack" "$temp_dir" "$temp_dir/icons" "$icon_map"
        or return
    end
    if test -z "$icons"
        __mkhwt_log info "icons directory is not provided, skip adding."
    else if not test -d "$icons"
        __mkhwt_log error "`$icons` is not a valid icons directory."
        return 1
    else
        cp -r "$icons/." "$temp_dir/icons"
    end
    __mkhwt_zip "$temp_dir/icons" "$theme_root/icons"
end
