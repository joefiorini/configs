fpath=($fpath $HOME/.zsh/func)
export RUBYLIB="$RUBYLIB:$HOME/Projects/vendor/rip/lib"
export PATH="$PATH:$HOME/Projects/vendor/rip/bin:$HOME/bin"
export PAGER="less"
export EDITOR="$HOME/Applications/MacVim.app/Contents/MacOS/Vim"
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export WORDCHARS="${WORDCHARS:s#/#}"
export CLICOLOR=1

# BUG: This needs to be set before eval `rip-config` is run in .zshrc
export RIPDIR=${RIPDIR:-"$HOME/.rip"}
