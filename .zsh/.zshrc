###### Autoloads
autoload -U promptinit
autoload colors         # named color arrays
colors

autoload -U go          # custom function to jump to project dirs
go

# use zmv plugin for easier bulk file renaming
autoload -U zmv
# load cdr plugin for remembering chpwd history
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

###### Options
setopt cdablevars       # cd into named vars
setopt prompt_subst     # enable var expansion in prompt

source ~/.zsh/history.zsh
source ~/.zsh/completions.zsh
source ~/.zsh/git.zsh
source ~/.zsh/title.zsh

# Force emacs mode
set -o emacs

###### Aliases

alias ll='/bin/ls -Gla'
alias gf='git fetch'
alias cwip='time cucumber -p wip'
alias cuke='time cucumber -p default'
alias cpkey="cat ~/.ssh/id_rsa.pub | pbcopy"
alias gignore="echo $1 >> .gitignore"
alias g='git'
alias mmv='noglob zmv -W'

alias lsdiff='git show --oneline --name-only'

alias ql='qlmanage -p 2>/dev/null'

###### Speed up tab completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

###### Functions

cppatch() {
  `git diff --no-prefix head^ $1 | pbcopy`
}

pless() {
  pygmentize $1 | less -r
}

vim() {
  $EDITOR $*
}

reload() {
  source ~/.zshenv
  source ~/.zshrc
}

customize() {
  vim ~/.zshrc && reload
}

whodoneit() {
  for x in $(git grep --name-only $1); do
    git blame -f -- $x | grep $1;
  done
}

blog-code() {

  LANG=$2
  test $LANG || LANG="ruby"

  echo "Formatting your $LANG code."

  pygmentize -f html -l $LANG $1 | tidy -omit -wrap 80 -bare --show-warnings no --output-html yes --doctype omit --tidy-mark no | sed 's/<title><\/title>//' | pbcopy
}

tellme() {
  eval "$*"
  growlnotify -t "Command Complete" -s -m "$*"
}

# make meta+bksp kill path components
function backward-kill-partial-word {
        local WORDCHARS="${WORDCHARS//[\/.]/}"
        zle backward-kill-word "$@"
}

zle -N backward-kill-partial-word
bindkey '^Xw' backward-kill-partial-word

print_table () {
  sed -n "/\"$1\".* do |t|$/,/end/ s/.*/&/ p" db/schema.rb
}

gtd() {
  if [[ -n "$@" ]]; then
    task="- $@"
    [[ $DEBUG = "1" ]] && echo "*$task*"
    echo "Writing new task to $TASKS_FILE..."
    backup="$TASKS_FILE.`date +%s`.backup"
    cat $TASKS_FILE > $backup
    echo "$task" | cat - $TASKS_FILE | sponge $TASKS_FILE
    changed=$(diff -w --unchanged-line-format= $TASKS_FILE $backup)
    if [[ "$changed" != "$task" ]]; then
      echo "Parity check failed, your tasks file is backed up at $backup. Please investigate and restore if necessary."
      echo "$changed"
    fi
  else
    e ~/Dropbox/clocktower/taskpaper.taskpaper
  fi
}

# rackup app in current directory
ru(){
  if [ -f 'config.ru' ]; then
    rackup config.ru $*
  elif [ -f 'app.rb' ]; then
    rackup app.rb $*
  else
    rackup $*
  fi
}

###### Prompt

autoload -U spectrum
spectrum

autoload -Uz vcs_info

local smiley="%(?,%{$FG[064]%}⊕%{$reset_color%},%{$FG[160]%}⊗%{$reset_color%})"

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{$FG[037]%}+%{$reset_color%}"
zstyle ':vcs_info:*' unstagedstr "%{$FG[160]%}!%{$reset_color%}"
zstyle ':vcs_info:*' formats "(%{$FG[064]%}%b%{$reset_color%}%u%c)"
zstyle ':vcs_info:*' actionformats \
        "[%{$FG[064]%}%r%{$reset_color%}|%{$FG[160]%}%a%{$reset_color%}]"
precmd () { vcs_info }

local jobs="%(1j, %{$FG[160]%}%j%{$reset_color%},)"
PROMPT='${smiley}${jobs} '
RPROMPT='%{$FG[136]%}$(rbenv prompt)%{$reset_color%} ${vcs_info_msg_0_}'

command_exists(){
  command -v "$1" &>/dev/null ;
}

###### hub
command_exists hub && eval "$(hub alias -s zsh)"
###### rbenv
command_exists rbenv && eval "$(rbenv init -)"
