function installdate --wraps='stat / | grep Birth' --description 'alias installdate=stat / | grep Birth'
  stat / | grep Birth $argv
        
end
