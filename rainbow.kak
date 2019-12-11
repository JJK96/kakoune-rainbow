declare-option range-specs rainbow
declare-option regex rainbow_opening "[\[{(]"

declare-option str-list rainbow_colors "red" "green" "blue" "yellow" "purple"

define-command rainbow %{
    set-option window rainbow "%val{timestamp}"
    try %{
        add-highlighter window/ ranges rainbow
    }
    evaluate-commands -draft %{
        set-register / "%opt{rainbow_opening}"
        execute-keys \%
        try %{
            rainbow-selection 0
        }
    }
}

define-command -hidden rainbow-selection -params 1 %{
    evaluate-commands %sh{
        index=$1
        set -- "$kak_opt_rainbow_colors"
        colors=( $@ )
        length=${#colors[@]}
        next_index=$(( (index + 1) % length ))
        color=${colors[index]}
        echo "
            execute-keys s<ret>m
            evaluate-commands -draft %{
                execute-keys <a-S>
                evaluate-commands -itersel %{
                    set-option -add window rainbow \"%val{selection_desc}|$color\"
                }
            }
            evaluate-commands -itersel -draft %{
                execute-keys H<a-\;>L
                try %{
                    rainbow-selection $next_index
                }
            }
        "
    }
}

define-command rainbow-disable %{
    remove-highlighter window/rainbow
}
