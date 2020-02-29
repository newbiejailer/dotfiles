# Enable colors
autoload -U colors && colors

# History setting
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Load alias if existent
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

# Edit line in vim buffer ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
# Enter vim buffer from normal mode
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

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

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
precmd() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
bindkey '^ ' autosuggest-accept

# prompt
# autoload -U promptinit; promptinit
# prompt redhat
ps1_user="%(!.%{$fg[red]%}.%{$fg[green]%})%n"
ps1_host="%{$fg[blue]%}%M"
ps1_remote_host="%{$fg[red]%}%M"
ps1_remote_prefix="%{$fg[red]%}R>"
ps1_path="%{$fg[cyan]%}[%~]"
ps1_suffix="%(?.%{$fg[green]%}.%{$fg[red]%})%(!.#.$)"

if [ -z "$SSH_CLIENT" ]; then
    # Local login
    PS1="%B$ps1_user $ps1_host%b$ps1_path%B$ps1_suffix%{$reset_color%}%b "
else
    # Login through SSH
    PS1="%B$ps1_remote_prefix$ps1_user $ps1_remote_host%b$ps1_path%B$ps1_suffix%{$reset_color%}%b "
fi
