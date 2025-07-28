function __mkhwt_log -a level -a message
    set -l LEVELS debug info warn error
    set -q LOG_LEVEL
    or set -l LOG_LEVEL info
    set -l LOG_LEVEL_INDEX (contains --index $LOG_LEVEL $LEVELS)
    or set -l LOG_LEVEL_INDEX 2
    set -l EFFECTIVE_LEVELS $LEVELS[$LOG_LEVEL_INDEX..]
    if contains $level $EFFECTIVE_LEVELS
        switch "$level"
            case debug
                echo DEBUG $message >&2
            case info
                echo (set_color green)INFO $message(set_color normal) >&2
            case warn
                echo (set_color yellow)WARN $message(set_color normal) >&2
            case error
                echo (set_color red)ERROR $message(set_color normal) >&2
        end
    end
end
