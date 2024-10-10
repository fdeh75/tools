#!/bin/bash

set -xe

mkdir -p "${HOME}/.local/zsh_custom/themes"
cat << 'EOF' > "${HOME}/.local/zsh_custom/themes/robbyrussell.zsh-theme"
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status} %{$fg_bold[magenta]%}%n%{$reset_color%}%{$FG[146]%}@%{$reset_color%}%{$fg_bold[blue]%}%m%{$reset_color%}  %{$fg_bold[cyan]%}%~%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
EOF

ZSHRC_FILE="${HOME}/.zshrc"

TEMP_FILE=$(mktemp)

sed 's|# ZSH_CUSTOM=/path/to/new-custom-folder|ZSH_CUSTOM=~/.local/zsh_custom|' "$ZSHRC_FILE" > "$TEMP_FILE"
mv "$TEMP_FILE" "$ZSHRC_FILE"
