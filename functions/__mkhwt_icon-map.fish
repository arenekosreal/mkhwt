function __mkhwt_icon-map -a iconpack -a action -a appid -a icon
    set -l appid_icon_map_json "$iconpack/appid_icon_map.json"
    switch "$action"
        case set
            jq -r ".\"$appid\" = \"$icon\"" "$appid_icon_map_json" >"$appid_icon_map_json.tmp"
            mv "$appid_icon_map_json.tmp" "$appid_icon_map_json"
        case get
            jq -r ".\"$appid\"" "$appid_icon_map_json"
        case reset
            echo "{}" >"$appid_icon_map_json"
        case appids
            jq -r "keys[]" "$appid_icon_map_json"
        case print-map-path
            echo "$appid_icon_map_json"
        case load
            cat >"$appid_icon_map_json" </dev/stdin
    end
end
