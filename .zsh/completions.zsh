setopt auto_menu
setopt complete_in_word # when completing, keep cursor inline
setopt always_to_end    # move cursor to end of word if match inserted
setopt no_case_glob     # case insensitive completions

autoload -U compinit       # tab completion
compinit -i

zmodload -i zsh/complist

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,command -w -w"
zstyle ':completion:*:*:(ssh|scp):*:*' hosts `sed 's/^\([^ ,]*\).*$/\1/' ~/.ssh/known_hosts`
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':completion:*:*:go:*:*' menu selection

source ~/.zsh/rake_completions.zsh
