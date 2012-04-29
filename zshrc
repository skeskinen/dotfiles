#!/bin/zsh

autoload -U colors && colors
autoload -U compinit && compinit

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# changing directories
setopt auto_cd
setopt auto_pushd
setopt cdable_vars
setopt chase_links
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home

# completion
setopt always_to_end
setopt auto_menu
setopt auto_name_dirs
setopt auto_param_keys
setopt auto_param_slash
setopt auto_remove_slash
setopt complete_aliases
setopt complete_in_word
setopt list_ambiguous
setopt list_packed
unsetopt menu_complete

# expansion and globbing
setopt extended_glob
setopt long_list_jobs
setopt multios
setopt prompt_subst

# input/output
setopt correct
unsetopt clobber
unsetopt flowcontrol
setopt interactive_comments
setopt rc_quotes
setopt short_loops

# job control
setopt bg_nice

# zle
setopt vi

for snippets ($HOME/etc/zsh/*.zsh(N))
  source $snippets
