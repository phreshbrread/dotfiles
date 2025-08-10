if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

starship init fish | source

fish_add_path /home/brad/.millennium/ext/bin

# Aliases
alias cls "clear"
alias sudo "doas"
alias sudoedit "doas rnano"
alias installdate "stat / | grep Birth"
alias ls "eza -alg --group-directories-first --icons=always"
