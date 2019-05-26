#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# if [ "$TERM" = "xterm" ]; then
#   export TERM=xterm-256color
# fi
export TERM=xterm-256color

# Source base16 256 colourspace script.
if [[ -s "$HOME/.colours/base16-shell/scripts/base16-outrun-dark.sh" ]]; then
  source "$HOME/.colours/base16-shell/scripts/base16-outrun-dark.sh"
fi

# Load direnv
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi

# Setup docker environment variables docker-machine
# if which docker-machine > /dev/null; then
#   eval "$(docker-machine env dev)";
# fi

# Aliases
# unalias gb

alias a='tmux attach -t'
alias g='git'
alias v='vim'
alias n='nvim'
alias t='tmux'
alias c='cd'
alias z='zeus'
alias s='spring'
alias be='bundle exec'
alias psql.server='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log'
alias gt='go test -v -cover ./...'
alias python='python3'
alias weather='curl wttr.in/sydney'
alias w='curl -s -N wttr.in/sydney | head -n 7'

if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi



function chpwd() {
  emulate -L zsh
  ls -F
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LD_LIBRARY_PATH=/usr/local/lib/
export PATH=/home/tom/julia/julia-1.1.0/bin:$PATH

. /home/tom/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

