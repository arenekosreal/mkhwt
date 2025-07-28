function __mkhwt_zip -a directory -a filename
    bsdtar -c -f "$filename" --format zip --strip-components (string split / "$directory" | count) "$directory"
end
