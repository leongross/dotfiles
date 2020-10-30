export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gallois_pp"
COMPLETION_WAITING_DOTS="true"

plugins=(git vi-mode zsh_reload zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Editor configuration
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
  	export EDITOR='vi'
fi

# pathing
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH" 
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/ctf/pwnbin" ] && PATH="$HOME/ctf/pwnbin:$PATH"
[ -d "$HOME/.gem/ruby/2.7.0/bin" ] && PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"


# environment exports
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'


# config shortcuts
alias vi="nvim"
alias vim="nvim"

alias vic="vi ~/.config/nvim/init.vim"
alias viz="vi ~/.zshrc && source ~/.zshrc"
alias vi3="vi ~/.config/i3/config && i3-msg restart"
alias vi3b="vi ~/.config/i3blocks/config && i3-msg restart"


# shortcuts
alias l="$HOME/.cargo/bin/exa -lamgS --color=automatic"
alias ls="exa -lmg"
alias ol="/bin/ls"
alias f="rg -i"
alias s="sudo"
alias e="ranger" 
alias c="cheat"
alias p="python3"
alias pe="python3 -c"
alias pm="sudo pacman $@"
alias cx="chmod +x"
function tbu { nc termbin.com 9999 } 
function tbd { wget "https://termbin.com/$1" -O "tb_"$1 }


# system utils
alias aslr_on="echo 0 | sudo tee /proc/sys/kernel/randomize_va_space"
alias aslr_off="echo 1 | sudo tee /proc/sys/kernel/randomize_va_space"


# git dotfiles aliases
alias conf="/usr/bin/git --git-dir=$HOME/.config --work-tree=$HOME"


# wine bindings
function ida32 { wine "~/.wine/drive_c/Program\ Files/IDA\ 7.0/ida.exe" $1}
function ida64 { wine "~/.wine/drive_c/Program\ Files/IDA\ 7.0/ida64.exe" $1 }


# aur specific plugin aliases ( aurutils )
alias aurs="aur sync $1"


# vpn alis
alias vpn_s_d="sudo openvpn --config /etc/openvpn/client/seedhost.ovpn --daemon openvpn_seedhost"
