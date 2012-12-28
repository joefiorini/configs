source "$HOME/.aws-env"
fpath=($HOME/.zsh/completions $HOME/.zsh $fpath)
export PATH="/Users/joe/.cabal/bin:./node_modules/.bin:/usr/local/bin:$PATH:$HOME/bin"
export PAGER="less"
export EDITOR="$HOME/Applications/MacVim.app/Contents/MacOS/Vim"
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export WORDCHARS="${WORDCHARS:s#/#}"
export CLICOLOR=1

export TASKS_FILE=~/Dropbox/clocktower/taskpaper.taskpaper

# JRuby load times sucks with server VM, force client VM instead
# (see http://blog.headius.com/2010/03/jruby-startup-time-tips.html)
export JAVA_OPTS="-d32"
export JRUBY_OPTS="-X-C --1.9" # Turning off JIT compiling also helps speed up load times

command_exists(){
  command -v "$1" &>/dev/null ;
}

###### rbenv
command_exists rbenv && eval "$(rbenv init -)"
