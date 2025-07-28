function __mkhwt_framework-res -a theme_root -a temp_dir -a framework_res
    mkdir -p "$temp_dir/framework-res"
    if test -z "$framework_res"
        __mkhwt_log info "Generating dummy framework-res directory..."
        begin
            echo '<resources>'
            echo '</resources>'
        end >"$temp_dir/framework-res/theme.xml"
    else if not test -f "$framework_res/theme.xml"
        __mkhwt_log error "`$framework_res` is not a valid framework-res directory."
        return 1
    else
        cp -r "$framework_res/." "$temp_dir/framework-res"
    end
    __mkhwt_zip "$temp_dir/framework-res" "$theme_root/framework-res"
end
