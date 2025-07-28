for f in ./functions/*.fish
    source "$f"
end

if string match -q -- "*from sourcing file*" (status)
    for f in ./completions/*.fish
        source "$f"
    end
else
    mkhwt $argv
end
