## Sourcing External Configs
source ~/.aliases
source ~/.exports
source ~/.functions

shopt -s extglob 2>/dev/null
set -o noclobber

export HISTCONTROL=ignoredups
unset HISTFILE

[ "$UID" ] || UID=`id -u`
usercolor='01;33'
dircolor='01;34'
case "$TERM" in
  *-256color)
  usercolor='38;5;184'
  dircolor='38;5;27'
  ;;
  *-88color|rxvt-unicode)
  usercolor='38;5;56'
  dircolor='38;5;23'
  ;;
esac
[ $UID = '0' ] && usercolor="01;37"

if [ -x /usr/bin/tty -o -x /usr/local/bin/tty ]; then
  ttybracket=" [`tty|sed -e s,^/dev/,,`]"
  ttyat="`tty|sed -e s,^/dev/,,`@"
fi

#PS1='\n┏━\[\e[7m\]┅◉ \[\e[1;37m\] <Machine> ◉━\[\e[0m\]━━\[\e[7m\]┅◉ @ \[\e[1;37m\] $(ip) ◉━\[\e[0m\]━━\[\e[7m\]┅◉ λ \[\e[1;37m\] $(parse_git_branch) \[\e[7m\] ◉━\[\e[0m\]━━\[\e[7m\]┅◉ ≣ \[\e[1;37m\] $(gittotalstash) ➤ $(gitstashtop) ◉ \[\e[1;37m\]\[\e[0m\] \n┣┅◉  \[\033[1;34m\] `pwd` \[\e[0m\] \n┗\[\e[7m\]┅◉ 웃 \[\e[1;37m\] \u ◉━\[\e[0m\]━> '
#PS1='\n┏━━┅◉  IP ➤ \[\e[1;37m\]$(ip)\[\e[0m\] ◉━━━┅◉  Git Branch ➤ \[\e[1;37m\]$(parse_git_branch)\[\e[0m\] ◉━━━┅◉  Stash ➤ \[\e[1;37m\]$(gittotalstash) (\[\e[0m\]$(gitstashtop)...\[\e[1;37m\])\[\e[0m\] \n┣┅◉  Current Dir ➤ \[\e[1;37m\]$(pwd)\[\e[0m\] \n┗━┅◉  User ➤\[\e[1;37m\] \u \[\e[0m\]◉━━┅◉ '
#PS1='\n┏━━┅◉  IP ➤ \[\e[1;37m\]$(ip)\[\e[0m\] ◉━━━┅◉  Git Branch ➤ \[\e[1;37m\]$(parse_git_branch)\[\e[0m\] ◉━━━┅◉  Stash ➤ \[\e[1;37m\]$(gittotalstash) (\[\e[0m\]$(gitstashtop)...\[\e[1;37m\])\[\e[0m\] \n┣┅◉  Current Dir ➤ \[\e[1;37m\]$(pwd)\[\e[0m\] \n┗━┅◉  User ➤\[\e[1;37m\] \u \[\e[0m\]◉━━┅◉> '
#PS1='\n┏━TIME┅⟦ \[\e[1;37m\]\@\[\e[0m\] ⟧ ◉━━IP┅⟦ \[\e[1;37m\]$(ip)\[\e[0m\] ⟧ ◉━━BRANCH┅⟦ \[\e[1;37m\]$(parse_git_branch)\[\e[0m\] ⟧ ◉━━STASH┅⟦ \[\e[1;37m\]$(gittotalstash)\[\e[0m\] ⟧ \n┣━PWD┅⟦ \[\e[1;37m\]\w\[\e[0m\] ⟧ \n┗━USER┅⟦ \[\e[1;37m\]\u\[\e[0m\] ⟧ ◉━━┅⟦ '
#PS1='\n\[\e[1;37m\]_dict\[\e[0m\] = \[\e[1;37m\]{\[\e[0m\]\"USER\": \[\e[1;37m\]\u\[\e[0m\], \"IP\": \[\e[1;37m\]$(ip)\[\e[0m\], \"TIME\": \[\e[1;37m\]\@\[\e[0m\], \"GIT_BRANCH\": \[\e[1;37m\]$(parse_git_branch)\[\e[0m\], \"STASH\": \[\e[1;37m\]$(gittotalstash)\[\e[0m\], \n         \"PWD\": \[\e[1;37m\]$(pwd)\[\e[0m\]\n         \[\e[1;37m\]}\[\e[0m\] '
PS1="\n\[\e[35;1m\]{\[\e[35;0m\]USER: \[\e[37;1m\]\u\[\e[35;1m\]}---⪼  \[\e[35;1m\]{\[\e[35;0m\]IP: \[\e[37;1m\]\$(ip)\[\e[35;1m\]}---⪼  {\[\e[35;0m\]BRANCH: \[\e[37;1m\]\$(parse_git_branch)\[\e[35;1m\], \[\e[35;0m\]STASH: \[\e[37;1m\]\$(gittotalstash)\[\e[35;1m\], \[\e[35;0m\]STASH_TOP: \[\e[37;1m\]\$(gitstashtop)\[\e[35;1m\]} \n{\[\e[35;0m\]PWD: \[\e[37;1m\]\$(pwd)\[\e[35;1m\]}\n-⪼  \[\e[0m\]"

case "$TERM" in
  screen*|xterm*|rxvt*|Eterm*|kterm*|dtterm*|ansi*|cygwin*)
    PS1='\[\e]1;'$ttyat'\h\007\e]2;\u@\h:\w'$ttybracket'\007\]'"${PS1//01;3/00;9}"
  ;;
  linux*|vt220*) ;;
  *)
  PS1='\u@\h:\w\$ '
  ;;
esac

case $TERM in
  screen*)
    PS1="$PS1"'\[\ek'"$ttyat`[ "$STY" -o "$TMUX" ] || echo '\h'`"'\e\\\]'
    ;;
esac

[ ! -f /etc/bash_completion ] || . /etc/bash_completion

unset hostcolor usercolor dircolor ttybracket ttyat

#------------------------------------
# GIT auto completion
#------------------------------------
source /etc/bash_completion.d/git
