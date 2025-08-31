# .zshrc - ZSH configuration

# Setup Homebrew (macOS)
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS  # Don't record duplicate commands
setopt HIST_FIND_NO_DUPS     # Don't show duplicates when searching
setopt HIST_SAVE_NO_DUPS     # Don't write duplicate commands to history file
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blanks
setopt INC_APPEND_HISTORY    # Add commands as they are typed, not at shell exit
setopt EXTENDED_HISTORY      # Record command start time
setopt SHARE_HISTORY         # Share history between sessions

# Basic auto/tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colored completion
zstyle ':completion:*' verbose true
zstyle ':completion:*' rehash true                        # Automatically find new executables
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Useful options
setopt AUTO_CD               # If command is a directory path, cd into it
setopt AUTO_PUSHD            # Make cd push the old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS     # Don't push duplicate directories onto the stack
setopt PUSHD_SILENT          # Don't print the directory stack after pushd or popd
setopt CORRECT               # Command auto-correction
setopt COMPLETE_IN_WORD      # Complete from both ends of a word
setopt ALWAYS_TO_END         # Move cursor to the end of a completed word

# Vi mode
bindkey -v
export KEYTIMEOUT=1         # Reduce mode switching delay

# Set default editor
export EDITOR=nvim
export VISUAL=nvim

# Setting editor to vim puts zsh in vi mode for some reason
set -o emacs

# Set up the prompt with pretty colors
autoload -Uz colors && colors

# Simple git prompt function
git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo " %F{yellow}(${ref#refs/heads/})%f"
}

# Create prompt with git info
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$(git_prompt_info) %# '

# Add a right-side prompt with time
RPROMPT='[%F{yellow}%D{%H:%M:%S}%f]'

# Set colors for ls command
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# Enable color support
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Basic aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias vim='nvim'

# git aliases
alias gs='git status'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gf='git fetch origin'
gca() {
  git commit -am $1 && git push
}


# Add local bin directory to PATH if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Set less to not clear the screen upon exit
export LESS="-R"

# Enable colors for less
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # end mode
export LESS_TERMCAP_se=$'\E[0m'        # end standout-mode
export LESS_TERMCAP_so=$'\E[01;33m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'        # end underline
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline

# FZF integration if installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable syntax highlighting if plugin is installed
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Enable autosuggestions if plugin is installed
if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load local customizations if present
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completionexport PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
