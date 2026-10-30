if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting

    command -v zoxide &>/dev/null && zoxide init fish | source

    command -v lsd &>/dev/null && alias ls="lsd"

    cat ~/.cache/terminal-sequences 2>/dev/null

    alias s='firefox --search'
    alias ls='lsd'
    alias install='sudo pacman -S'
    alias uninstall='sudo pacman -Rdd'
    alias rgdb="rust-gdb"
    alias ff='fastfetch'
    alias tpfix='sudo modprobe -r psmouse && sudo modprobe psmouse'

    function mark_prompt_start --on-event fish_prompt
        cat ~/.cache/terminal-sequences 2>/dev/null
        echo -en "\e]133;A\e\\"
    end

end

#cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
# uv
fish_add_path "/home/user/.local/bin"
