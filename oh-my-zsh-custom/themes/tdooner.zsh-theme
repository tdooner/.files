source ~/.oh-my-zsh/themes/lukerandall.zsh-theme

SHORT_USERNAME="${USERNAME%%@*}"
PROMPT="%{$fg_bold[green]%}${SHORT_USERNAME}%{$reset_color%} %{$fg_bold[blue]%}%2~%{$reset_color%} $(my_git_prompt_info)%{$reset_color%}%B»%b "

# Look for any commits between upstream and here that have my git WIP pattern.
function work_in_progress_tdooner() {
  if $(git log 'master@{u}...HEAD' 2>/dev/null | grep -q -c "\-\- WIP \-\-"); then
    echo "%{$fg[red]%}WIP${ZSH_THEME_GIT_PROMPT_PREFIX%\(}"
  fi
}

# Include the git WIP-ness in the prompt
function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    GIT_STATUS=$(git_prompt_status)
    GIT_WIP=$(work_in_progress_tdooner)
    [[ -n $GIT_WIP ]] && GIT_WIP=" $GIT_WIP"
    [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$GIT_WIP$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
