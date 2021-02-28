#Autoloads
autoload -Uk ls
autoload -Uk PROMPT 
setopt AUTO_CD

#Tab compition
autoload -Uz compinit && compinit

#Historu
HISTFILE=$HOME/.zsh_history
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
SAVEHIST=10000
HISTSIZE=20000

#Aliasas
source ~/.aliases
#Functions
source ~/.functions
#Exports
source ~/.exports

#Prompt
PROMPT=$'%f%B%F{240}%1~%f %b${vcs_info_msg_0_}%(?.%{%F{white}%}.%{$red%})%(!.➜ .➜ ) %{$reset_color%}'

## case-insensitive (all) completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
precmd() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
# Control bindings for programs
#bindkey -s "^g" "lc\n"
#bindkey -s "^h" "history 1\n"
#bindkey -s "^l" "clear\n"
#bindkey -s "^d" "ls\n"

# Sourcing Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
source ~/.zsh/.git-comp.zsh
source ~/.zsh/keybind/key-bindings.zsh
source ~/.zsh/completion.zsh 

# vi mode
bindkey -v
export KEYTIMEOUT=1

# fzf init
# fzf key bindings.
if [ -x "$(command -v fzf)" ]; then
    source ~/.fzf/shell/key-bindings.zsh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FD_OPTIONS="--follow --hidden --exclude .git"
export FZF_CTRL_R_OPTS="--sort --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_OPTS="--no-mouse --height 40% --layout reverse"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fdfind -t f -t l $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --multi --info inline --border"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
