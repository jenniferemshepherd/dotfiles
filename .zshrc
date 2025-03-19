echo "✅ .zshrc successfully loaded!"

# =======================================
# 🚀 Oh My Zsh Configuration
# =======================================

# TODO: Decide if I want to continue using Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins (Be mindful of performance impact)
plugins=(
    git
    node
    npm
    zsh-autosuggestions
    z
)

[[ -f ~/.aliases ]] && source ~/.aliases


# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh


# =======================================
# ⌛ History & Command Behavior
# =======================================

# Corrects typos
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"  # Shows dots when waiting for completion

# History settings
export HISTSIZE=10000  # Increase stored commands
export SAVEHIST=10000  # Save history across sessions
export HISTFILE=~/.zsh_history  # Define history file location
HIST_STAMPS="%m/%d/%Y %H:%M:%S"  # Format: MM/DD/YYYY HH:MM:SS
setopt HIST_IGNORE_ALL_DUPS  # Ignore duplicate commands in history
setopt SHARE_HISTORY  # Share history across multiple sessions

# Enable cd without typing `cd`
setopt AUTO_CD
setopt AUTO_PUSHD # Automatically push directories onto the directory stack

# =======================================
# 🏗️ Path Configuration
# =======================================

# Volta setup
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Append node_modules/.bin if it exists (Only adds when applicable)
if [[ -d "./node_modules/.bin" ]]; then
    export PATH="./node_modules/.bin:$PATH"
fi


# =======================================
# 📌 User Configuration
# =======================================

export EDITOR="code"  # Default editor
export LC_ALL=en_GB.UTF-8 # Set locale to UK English
export LANG=en_GB.UTF-8 # Set language to UK English


# =======================================
# 🐙 Git Enhancements
# =======================================

# Show Git branch in the prompt and current directory in the terminal title
autoload -Uz vcs_info
precmd() { 
    vcs_info  # Load Git branch info
    echo -ne "\033]0;${PWD##*/}\007"  # Update terminal title
}
zstyle ':vcs_info:git:*' formats '(%F{yellow} %b%f) '
PS1='%n@%m %1~ ${vcs_info_msg_0_} %(!.#.$) ' brew cleanup

