declare-option -hidden range-specs rainbow
declare-option regex rainbow_opening "[\[{(]"
declare-option bool rainbow_highlight_background false

declare-option str-list rainbow_faces "bright-red" "bright-green" "bright-yellow" "bright-blue" "bright-magenta" "bright-cyan"

define-command rainbow %{
    set-option window rainbow "%val{timestamp}"
    try %{
        add-highlighter window/ ranges rainbow
    }
    evaluate-commands -save-regs '/' -draft %{
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
        eval "set -- $kak_quoted_opt_rainbow_faces"
        length=$#
        next_index=$(( (index + 1) % (length - 1) ))
        index=$(( index + 1 ))
        eval face=\$$index
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
            execute-keys <a-K>\A..\z<ret> #if there is no content do not recurse
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
