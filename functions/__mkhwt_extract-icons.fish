function __mkhwt_extract-icons -a apk -a iconpack
    # TODO: Other possible paths contain icons?
    bsdtar -x --strip-components 2 -C "$iconpack" -f "$apk" "res/drawable-nodpi-v4/*"
end
