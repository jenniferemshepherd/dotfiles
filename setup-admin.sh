#!/bin/zsh

set -e  # Exit immediately if any command fails

echo "👑 Running Homebrew installation as admin..."

# Ensure Homebrew is installed
if ! command -v brew &>/dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "🍺 Homebrew installed and configured."
else
    echo "✅ Homebrew is already installed."
fi

# Ensure correct permissions on Homebrew directories
echo "🔧 Fixing Homebrew permissions..."
sudo chown -R $(whoami):admin /opt/homebrew
sudo chmod -R u+rwX /opt/homebrew

# Add Homebrew to PATH
if [[ "$(uname -m)" == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' | sudo tee -a /etc/zshrc
else
    eval "$(/usr/local/bin/brew shellenv)"
    echo 'eval "$(/usr/local/bin/brew shellenv)"' | sudo tee -a /etc/zshrc
fi

# Install apps from Brewfile
BREWFILE_PATH="/Users/jennifer.shepherd/dotfiles/Brewfile"

if [[ -f "$BREWFILE_PATH" ]] && [[ -s "$BREWFILE_PATH" ]]; then
    # keep brewfile updated by running: brew bundle dump --file=~/dotfiles/Brewfile --force
    echo "📦 Installing apps from Brewfile..."
    brew bundle --file="$BREWFILE_PATH"
else
    echo "⚠️ No Brewfile found or Brewfile is empty. Skipping."
fi

echo "✅ Homebrew setup complete!"




    # # Add Homebrew to PATH (for Apple Silicon & Intel); modifies shell configuration so that brew commands work in every new terminal session
    # if [[ "$(uname -m)" == "arm64" ]]; then
    #     eval "$(/opt/homebrew/bin/brew shellenv)"
    #     echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile  # Persist in .zprofile
    # else
    #     eval "$(/usr/local/bin/brew shellenv)"
    #     echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile  # Persist in .zprofile
    # fi
