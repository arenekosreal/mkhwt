function __mkhwt_framework-res-hwext -a theme_root -a temp_dir -a framework_res_hwext
    mkdir -p "$temp_dir/framework-res-hwext"
    if test -z "$framework_res_hwext"
        __mkhwt_log info "Generating dummy framework-res-hwext directory..."
    else if not test -d "$framework_res_hwext"
        __mkhwt_log error "`$framework_res_hwext` is not a valid framework-res-hwext directory."
        return 1
    else
        cp -r "$framework_res_hwext/." "$temp_dir/framework-res-hwext"
    end
    __mkhwt_zip "$temp_dir/framework-res-hwext" "$theme_root/framework-res-hwext"
end
