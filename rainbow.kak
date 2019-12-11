declare-option -hidden range-specs rainbow
declare-option regex rainbow_opening "[\[{(]"
declare-option bool rainbow_highlight_background false

declare-option str-list rainbow_faces "red" "green" "blue" "yellow" "purple"


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
        set -- $kak_opt_rainbow_faces
        length=$#
        next_index=$(( (index + 1) % length ))
        eval face=\$$(( index + 1 ))
        select_ends=""
        if ! $kak_opt_rainbow_highlight_background; then
            select_ends="execute-keys <a-S>"
        fi
        echo "
            execute-keys s<ret>m
            evaluate-commands -draft %{
                $select_ends
                evaluate-commands -itersel %{
                    set-option -add window rainbow \"%val{selection_desc}|$face\"
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

define-command rainbow-enable %{
    hook -group rainbow window InsertIdle .* %{ rainbow }
    hook -group rainbow window NormalIdle .* %{ rainbow }
}

define-command rainbow-disable %{
    remove-highlighter window/ranges_rainbow
    remove-hooks window rainbow
}
