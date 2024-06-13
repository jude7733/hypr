#ENV
export BROWSER="firefox"
export EDITOR="nvim"
export VISUAL="nvim"
export CDPATH=".:$HOME:$HOME/.config/"
alias vim="nvim"
alias v="nvim"

#space before command
precmd() {print ""}

HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=500
bindkey -e

autoload -Uz compinit
setopt PROMPT_SUBST
compinit
zstyle ':completion:*' menu select

plugins=(git zsh-autosuggestions)

#Fastfetch
if [[ $(tty) == *"pts"* ]]; then
    fastfetch --config examples/13
else
    echo
    if [ -f /bin/hyprctl ]; then
        echo "Start Hyprland with command Hyprland"
    fi
fi

function parse_git_dirty {
  STATUS="$(git status 2> /dev/null)"
  if [[ $? -ne 0 ]]; then printf ""; return; else printf " ["; fi
  if echo ${STATUS} | grep -c "renamed:"         &> /dev/null; then printf " >"; else printf ""; fi
  if echo ${STATUS} | grep -c "branch is ahead:" &> /dev/null; then printf " !"; else printf ""; fi
  if echo ${STATUS} | grep -c "new file::"       &> /dev/null; then printf " +"; else printf ""; fi
  if echo ${STATUS} | grep -c "Untracked files:" &> /dev/null; then printf " ?"; else printf ""; fi
  if echo ${STATUS} | grep -c "modified:"        &> /dev/null; then printf " *"; else printf ""; fi
  if echo ${STATUS} | grep -c "deleted:"         &> /dev/null; then printf " -"; else printf ""; fi
  printf " ]"
}

parse_git_branch() {
  # Long form
  git rev-parse --abbrev-ref HEAD 2> /dev/null
 # Short form
  # git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/.*\/\(.*\)/\1/'
}

PROMPT='%B%F{050} 󰣇 %B%F{015}%~%B%F{006} %b%F{015} '
RPROMPT='%B%F{006}$(parse_git_branch)%F{003}$(parse_git_dirty) %B%F{015}%t'
