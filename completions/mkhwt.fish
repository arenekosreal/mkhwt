complete -c mkhwt -r -s t -l title -d "Set theme title and output filename."
complete -c mkhwt -r -s p -l preview -d "Where is the directory contains preview files." -a '(__fish_complete_directories "" "Preview directory.")'
complete -c mkhwt -r -s i -l icons -d "The appid or apk file of icon pack." -a '(__fish_complete_path ".apk" "The icon pack apk.")'
complete -c mkhwt -r -s I -l icon-pack -d "Where is the directory contains icons." -a '(__fish_complete_directories "" "Icons directory.")'
complete -c mkhwt -r -s c -l icon-map -d "The map json with appid as keys and icon as values." -a '(__fish_complete_path ".json" "The icon map json.")'
complete -c mkhwt -r -s f -l fonts -d "Where is the directory contains fonts." -a '(__fish_complete_directories "" "Font directory.")'
complete -c mkhwt -r -s w -l wallpaper -d "Where is the directory contains wallpaper." -a '(__fish_complete_directories "" "Wallpaper directory.")'
complete -c mkhwt -r -s u -l unlock -d "Where is the directory contains unlock images." -a '(__fish_complete_directories "" "Unlock images directory.")'
complete -c mkhwt -r -s r -l framework-res -d "Where is the framework-res of theme." -a '(__fish_complete_directories "" "framework-res directory.")'
complete -c mkhwt -r -s R -l framework-res-hwext -d "Where is the framework-res-hwext of theme." -a '(__fish_complete_directories "" "framework-res-hwext directory.")'
complete -c mkhwt -r -s T -l title-cn -d "The name of theme in Chinese."
complete -c mkhwt -r -s a -l author -d "The name of theme author."
complete -c mkhwt -r -s d -l designer -d "The name of theme designer."
complete -c mkhwt -r -s s -l screen -d "The size of screen supported by theme." -a 'FHD XXHD'
complete -c mkhwt -r -s v -l version -d "The version of theme."
complete -c mkhwt -r -s o -l font -d "The font of theme."
complete -c mkhwt -r -s O -l font-cn -d "The font of theme in Chinese."
complete -c mkhwt -r -s b -l briefinfo -d "The briefinfo of theme."
complete -c mkhwt -s W -l wallpaper-dark -d "If the theme has dark wallpaper."
complete -c mkhwt -s h -l help -d "Print help."
