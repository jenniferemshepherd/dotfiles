echo "✅ .zshrc successfully loaded!"
export HOME="/Users/jennifer.shepherd"

# =======================================
# 🚀 Oh My Zsh Configuration
# =======================================

# Ensure Oh My Zsh is properly sourced
echo "Sourcing Oh My Zsh..."
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    source "$ZSH/oh-my-zsh.sh"
else
    echo "⚠️ Warning: Oh My Zsh not found! Run setup.sh to install it."
fi


# Plugins (Be mindful of performance impact)
plugins=(
    git
    node
    npm
    zsh-autosuggestions
    z
)

[[ -f ~/.aliases ]] && source ~/.aliases


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

# Homebrew setup (Ensure Homebrew tools take priority)
export PATH="/opt/homebrew/bin:$PATH"

# Initialize Homebrew environment (recommended for Apple Silicon)
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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
precmd() { 
    echo -ne "\033]0;${PWD##*/}\007"  # Update terminal title
}
