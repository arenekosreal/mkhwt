# mkhwt

Create customized Huawei theme based on icon pack and fonts, etc.

## Usage

- Install [fish](https://fishshell.com)
- Choose one of methods below:
    - Source or run [mkhwt.fish](./mkhwt.fish).

        If you source it, you will have function `mkhwt` and its completions.

        If you run it, it just like you run `mkhwt` function directly, you need to pass all arguments required.

    - Copy [completions](./completions) and [functions](./functions) directory to `~/.config/fish`.

        You will have `mkhwt` function and its completions each time you launch fish.
- Run command like `mkhwt --help` to get detailed help.

## Requirements

- fish
- cp
- mv
- bsdtar
- magick
- xmllint
- mkdir
- jq
- cat
        