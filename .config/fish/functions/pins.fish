function pins
    yay -Slq | fzf --multi \
        --preview 'yay -Si {1}' \
        --preview-window=right:60% \
        | xargs -ro yay -S
end
