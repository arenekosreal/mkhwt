function __mkhwt_map-icons -a icons -a apk -a iconpack -a icon_map
    # TODO: More stable way to get map of appid and icon?
    set -l APPFILTER_ARCHIVE_PATH "assets/appfilter.xml"
    set -l appfilter "$iconpack/appfilter.xml"
    if bsdtar -t -f "$apk" "$APPFILTER_ARCHIVE_PATH" >/dev/null
        __mkhwt_log debug "Extracting appfilter.xml..."
        bsdtar -x --strip-components (path dirname "$APPFILTER_ARCHIVE_PATH" | string split / | count) -C "$iconpack" -f "$apk" "$APPFILTER_ARCHIVE_PATH"
    else
        __mkhwt_log error "Unable to find appfilter.xml in icon pack apk."
        return 1
    end
    if string match "*.json" "$icon_map"
        and test -f "$icon_map"
        __mkhwt_log info "Using existing icon map $icon_map."
        __mkhwt_icon-map "$iconpack" load <"$icon_map"
    else
        __mkhwt_log info "Using an empty icon map."
        __mkhwt_icon-map "$iconpack" reset
    end
    __mkhwt_log info "Updating icon map based on current icon pack..."
    __mkhwt_log info "You can get updated icon map file at "(__mkhwt_icon-map "$iconpack" print-map-path)"."
    xmllint --xpath "/resources/item[@component][@drawable]" "$appfilter" | while read -l item
        set -l appid
        set -l activity
        set -l icon
        __mkhwt_log debug "Found $item."
        if echo "$item" | xmllint --xpath '/item/@component' - | string match -rgq -m 1 '{(?<appid>[\w\.]+)/(?<activity>[\w\.]+)}'
            and echo "$item" | xmllint --xpath '/item/@drawable' - | string match -rgq -m 1 '"(?<icon>\w+)"'
            __mkhwt_log debug "Found raw map $appid/$activity -> $icon."
            if test "$appid" = "com.android.contacts"
                and test "$activity" = "com.android.contacts.activities.DialtactsActivity"
                __mkhwt_log info "Overriding appid to com.android.contacts.activities.DialtactsActivity..."
                set appid com.android.contacts.activities.DialtactsActivity
            end
            set -l icon_lower (string lower "$icon")
            set -l icon_current (__mkhwt_icon-map "$iconpack" get "$appid")
            switch "$icon_current"
                case null
                    if test "$appid" = "com.android.mms"
                        and string match -q "com.yulong.android.contacts.*" "$activity"
                        __mkhwt_log warn "Find invalid icon for com.android.mms, skipping."
                    else if test -f "$iconpack/$icon.png"
                        __mkhwt_log info "Find icon $icon for $appid."
                        __mkhwt_icon-map "$iconpack" set "$appid" "$icon"
                    else if test -f "$iconpack/$icon_lower.png"
                        __mkhwt_log info "Find icon $icon_lower for $appid."
                        __mkhwt_icon-map "$iconpack" set "$appid" "$icon_lower"
                    else
                        __mkhwt_log warn "Unable to find icon for $appid, skipping."
                    end
                case "$icon" "$icon_lower"
                    __mkhwt_log info "$appid has already had a same icon, skipping."
                case "*"
                    if test -f "$iconpack/$icon_current.png"
                        __mkhwt_log warn "$appid has already had a different icon, skipping."
                    else if test -f "$iconpack/$icon.png"
                        __mkhwt_log warn "$appid in icon map has a missing icon, using $icon instead."
                        __mkhwt_icon-map "$iconpack" set "$appid" "$icon"
                    else if test -f "$iconpack/$icon_lower.png"
                        __mkhwt_log warn "$appid in icon map has a missing icon, using $icon_lower instead."
                        __mkhwt_icon-map "$iconpack" set "$appid" "$icon_lower"
                    else
                        __mkhwt_log warn "$appid in icon map has a missing icon without a replacement, skipping."
                    end
            end
        end
    end
    __mkhwt_icon-map "$iconpack" appids | while read -l appid
        set -l icon (__mkhwt_icon-map "$iconpack" get "$appid")
        if test "$icon" != null
            cp "$iconpack/$icon.png" "$icons/$appid.png"
        end
    end
    xmllint --xpath "/resources/iconback[1]/@*" "$appfilter" | while read -l attributes
        set -l id
        set -l value
        if string match -rgq "img(?<id>\d+)=\"(?<value>.+)\"" "$attributes"
            if test "$id" -lt 10
                set id 0$id
            end
            if test -f "$iconpack/$value.png"
                __mkhwt_log info "Find background template $id: $value.png"
                cp "$iconpack/$value.png" "$icons/icon_background_$id.png"
            end
        end
    end
    set -l value
    xmllint --xpath "/resources/iconmask[1]/@img1" "$appfilter" | string match -rgq "img1=\"(?<value>.+)\""
    if test -f "$iconpack/$value.png"
        __mkhwt_log info "Find mask template: $value.png"
        magick "$iconpack/$value.png" -background white -alpha remove -negate -fuzz 95% -transparent white "$icons/icon_mask.png"
    end
    xmllint --xpath "/resources/iconupon[1]/@img1" "$appfilter" | string match -rgq "img1=\"(?<value>.+)\""
    if test -f "$iconpack/$value.png"
        __mkhwt_log info "Find border template: $value.png"
        cp "$iconpack/$value.png" "$icons/icon_border.png"
    end
end