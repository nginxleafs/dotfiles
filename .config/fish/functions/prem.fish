function prem
    yay -Qeq | fzf --multi \
        --preview 'yay -Qi {1}' \
        --preview-window=right:60% \
        | xargs -ro sudo pacman -Rns
end
