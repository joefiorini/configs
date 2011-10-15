###### Autoloads
autoload -U promptinit
autoload colors         # named color arrays
colors

autoload -U go          # custom function to jump to project dirs
go

###### Options
setopt auto_cd          # auto cd when dir name is typed
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
alias gs='git stash'
alias gsp='git stash pop'
alias gf='git fetch'
alias blog='cd ~/Sites/blog.densitypop.com'
alias cwip='time cucumber -p wip'
alias cuke='time cucumber -p default'
alias cpkey="cat ~/.ssh/id_rsa.pub | pbcopy"

###### Speed up tab completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

###### Directory Shortcuts

if [ -f ~/.zshdirs ]; then
  source ~/.zshdirs
fi

###### Functions

pless() {
  pygmentize $1 | less -r
}

e() {
  $EDITOR $*
}

reload() {
  source ~/.zshenv
  source ~/.zshrc
}

customize() {
  e ~/.zshrc
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

color-my-ruby() {
  pygmentize -f rtf -O style=colorful -l ruby $1 | pbcopy
}

color-my-code() {
  pygmentize -f rtf -O style=colorful $* | pbcopy
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

mdown() {
  ruby -rubygems -e "require 'rdiscount'; puts RDiscount.new(File.read(ARGV[0]), :smart).to_html" -- $1
}

zle -N backward-kill-partial-word
bindkey '^Xw' backward-kill-partial-word

command_exists(){
  command -v "$1" &>/dev/null ;
}

print_table () {
  sed -n "/\"$1\".* do |t|$/,/end/ s/.*/&/ p" db/schema.rb
}

###### Prompt

PS1="%n@%m:%~%# "
source "$HOME/.zsh/func/prompt_jaf_setup"

###### hub
command_exists hub && eval `hub alias -s zsh`

###### rbenv
command_exists rbenv && eval "$(rbenv init -)"

###### rvm
#
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
