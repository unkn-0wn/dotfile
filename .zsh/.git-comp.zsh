setopt PROMPT_SUBST

autoload -U add-zsh-hook
autoload -Uz vcs_info

# Use True color (24-bit) if available.
if [[ "${terminfo[colors]}" -ge 256 ]]; then
    turquoise="%F{73}"
    orange="%F{179}"
    red="%F{167}"
    limegreen="%F{107}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    red="%F{red}"
    limegreen="%F{green}"
fi

# Reset color.
reset_color="%f"

# VCS style formats.
FMT_UNSTAGED="%{$reset_color%} %{$orange%}●"
FMT_STAGED="%{$reset_color%} %{$limegreen%}✚"
FMT_ACTION="(%{$limegreen%}%a%{$reset_color%})"
FMT_VCS_STATUS="on %{$turquoise%} %b%u%c%{$reset_color%}"

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr    "${FMT_UNSTAGED}"
zstyle ':vcs_info:*' stagedstr      "${FMT_STAGED}"
zstyle ':vcs_info:*' actionformats  "${FMT_VCS_STATUS} ${FMT_ACTION}"
zstyle ':vcs_info:*' formats        "${FMT_VCS_STATUS}"
zstyle ':vcs_info:*' nvcsformats    ""
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# Check for untracked files.
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
            git status --porcelain | grep --max-count=1 '^??' &> /dev/null; then
        hook_com[staged]+="%{$reset_color%} %{$red%}●"
    fi
}

# Executed before each prompt.
add-zsh-hook precmd vcs_info
