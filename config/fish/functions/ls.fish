function ls --wraps='eza -al --group-directories-first --icons=always' --description 'alias ls=eza -al --group-directories-first --icons=always'
  eza -al --group-directories-first --icons=always $argv
        
end
