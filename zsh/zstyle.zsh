# fixme - the load process here seems a bit bizarre

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol

setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

_force_rehash() {
  (( CURRENT = 1 )) && rehash
  return 1
}

zstyle ':completion::complete:*'          use-cache 1

# format autocompletion style
zstyle ':completion:*:descriptions'       format "%{$c1%}%d%{$reset_color%}"
zstyle ':completion:*:corrections'        format "%{$c3%}%d%{$reset_color%}"
zstyle ':completion:*:messages'           format "%{$c1%}%d%{$reset_color%}"
zstyle ':completion:*:warnings'           format "%{$c1%}%d%{$reset_color%}"
zstyle ':completion:*:default'            list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*'                    matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*'                    list-colors ''
zstyle ':completion:*'                    completer _oldlist _expand _force_rehash _complete _match _approximate
zstyle ':completion:*'                    menu select=2

zstyle ':completion:*:functions'          ignored-patterns '_*'
zstyle ':completion:*:match:*'            original only
zstyle ':completion:*:approximate:*'      max-errors 1 numeric

zstyle ':completion:*:cd:*'               tag-order local-directories directory-stack path-directories

# PACMAN {{{2
zstyle ':completion:*:pacman:*'           force-list always
zstyle ':completion:*:*:pacman:*'         menu yes select

# KILL {{{2
zstyle ':completion:*:kill:*'             force-list always
zstyle ':completion:*:*:kill:*'           command 'ps -e -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*'           menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# VIM {{{2
zstyle ':completion:*:*:(vim):*:*files'   ignored-patterns '*~|*.(old|bak|o|hi)'
zstyle ':completion:*:*:(vim):*:*files'   file-sort modification
zstyle ':completion:*:*:(vim):*'          file-sort modification
zstyle ':completion:*:*:(vim):*'          tag-order files

# SSH {{{2
_etc_hosts=()
[[ -r /etc/hosts ]] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

zstyle ':completion:*:hosts'              hosts $_etc_hosts
unset _etc_hosts

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
  bin daemon mail ftp http nobody dbus avahi named git bitlbee mpd \
  rtkit ntp usbmux gdm