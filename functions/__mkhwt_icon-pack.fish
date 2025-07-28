function __mkhwt_icon-pack -a icon_pack -a temp_dir -a icons -a icon_map
    mkdir -p "$temp_dir/iconpack"
    if string match -q "*.apk" "$icon_pack"
        and test -f "$icon_pack"
        __mkhwt_log info "Extracting icon pack from apk file $icon_pack."
        cp "$icon_pack" "$temp_dir/iconpack.apk"
    else if command -v pm >/dev/null
        # Running on Android devices directly
        __mkhwt_log info "Extracting icon pack from installed apk file of appid $icon_pack."
        set -l apks (pm path "$icon_pack" | string split : -f 2)
        set -l apk
        if test (count $apks) -gt 1
            set apk (string match -re 'base\.apk$' $apks)
        else
            set apk $apks[1]
        end
        __mkhwt_log debug "Found icon pack apk $apk."
        cp "$apk" "$temp_dir/iconpack.apk"
    else if command -v adb >/dev/null
        # Running on PC and connected an Android device accessable by adb
        __mkhwt_log info "Extracting icon pack from devices connected."
        set -l apks (adb shell pm path "$icon_pack" | string split : -f 2)
        set -l apk
        if test (count $apks) -gt 1
            set apk (string match -re 'base\.apk$' $apks)
        else
            set apk $apks[1]
        end
        __mkhwt_log debug "Found icon pack apk $apk."
        adb pull "$apk" "$temp_dir/iconpack.apk"
    else
        __mkhwt_log error "Unable to extract icons from icon pack."
        return 1
    end
    __mkhwt_log debug "Extracting icons..."
    __mkhwt_extract-icons "$temp_dir/iconpack.apk" "$temp_dir/iconpack"
    or return
    __mkhwt_log debug "Mapping icons..."
    __mkhwt_map-icons "$icons" "$temp_dir/iconpack.apk" "$temp_dir/iconpack" "$icon_map"
    or return
end
