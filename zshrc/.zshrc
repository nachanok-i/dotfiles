# Start configuration added by Zim Framework install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh
# }}} End configuration added by Zim Framework install

# ─── Prompt Profiles ─────────────────────────────────────────────
autoload -Uz vcs_info add-zsh-hook
setopt PROMPT_SUBST

function _prompt_precmd() { vcs_info }
add-zsh-hook precmd _prompt_precmd

# Personal: Catppuccin Mocha — two-line, full path, git, duration
function personal-mode() {
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr   '%F{#a6e3a1}+%f'
  zstyle ':vcs_info:git:*' unstagedstr '%F{#f38ba8}!%f'
  zstyle ':vcs_info:git:*' formats       ' %F{#585b70}[%f%F{#cba6f7}%b%f%c%u%F{#585b70}]%f'
  zstyle ':vcs_info:git:*' actionformats ' %F{#585b70}[%f%F{#cba6f7}%b%F{#f38ba8}|%a%f%c%u%F{#585b70}]%f'
  zstyle ':zim:duration-info' threshold 1
  zstyle ':zim:duration-info' format ' %F{#7f849c}⏱ %d%f'

  PROMPT='%F{#7f849c}╭─%f %F{#cba6f7}%n%f%F{#7f849c}@%f%F{#fab387}%m%f %F{#89b4fa}%~%f${vcs_info_msg_0_}${duration_info}
%F{#7f849c}╰─%f %(?.%F{#a6e3a1}❯%f.%F{#f38ba8}❯%f) '
  RPROMPT=''
}

# AI: minimal, robbyrussell-style — dirname only, branch, dirty flag
function ai-mode() {
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr   ' %F{red}✗%f'
  zstyle ':vcs_info:git:*' unstagedstr ' %F{red}✗%f'
  zstyle ':vcs_info:git:*' formats       ' %F{yellow}git:(%F{red}%b%F{yellow})%f%c%u'
  zstyle ':vcs_info:git:*' actionformats ' %F{yellow}git:(%F{red}%b%F{yellow}|%F{red}%a%F{yellow})%f%c%u'
  zstyle ':zim:duration-info' threshold 999999

  PROMPT='%(?.%F{green}➜%f.%F{red}➜%f)  %F{cyan}%1~%f${vcs_info_msg_0_} '
  RPROMPT=''
}

personal-mode

# Aliases for different Neovim distributions
alias lzv="NVIM_APPNAME=lazyvim nvim"
alias nvc="NVIM_APPNAME=nvchad nvim"
alias atv="NVIM_APPNAME=astronvim nvim"
alias lzg="lazygit"

export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
