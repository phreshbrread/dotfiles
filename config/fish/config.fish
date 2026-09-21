if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

starship init fish | source

direnv hook fish | source

# Aliases
alias cat            "bat"
alias x              "exit"
alias ls             "eza -algh --group-directories-first --icons=always"
alias cls            "clear"
alias tmux-mc        "tmux a -t minecraft-server"
alias sudoedit       "doas rnano"
alias install-date   "stat / | grep Birth"
alias tmux-terraria  "tmux a -t terraria-server"
alias nv             "nvim"
alias ff             "fastfetch"
alias cat            "bat"
alias gpr            "git pull --rebase"
alias apply-dotfiles "~/dotfiles/scripts/apply-dotfiles.sh"
