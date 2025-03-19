#!/bin/zsh

set -e  # Exit immediately if any command fails


# Check for and install Xcode Command Line Tools
echo "🛠 Checking for Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
    echo "📥 Installing Xcode Command Line Tools..."
    xcode-select --install
else
    echo "✅ Xcode Command Line Tools already installed."
fi


# Install Homebrew
echo "🍺 Checking for Homebrew..."
if ! command -v brew &>/dev/null; then
    echo "📥 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH (for Apple Silicon & Intel); modifies shell configuration so that brew commands work in every new terminal session
    if [[ "$(uname -m)" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    echo "🍺 Setting up Homebrew..."
else
    echo "✅ Homebrew is already installed."
fi


# keep brewfile updated by running: brew bundle dump --file=~/dotfiles/Brewfile --force
echo "📦 Installing apps from Brewfile..."
if [[ -f ~/dotfiles/Brewfile ]] && [[ -s ~/dotfiles/Brewfile ]]; then
    brew bundle --file=~/dotfiles/Brewfile
else
    echo "⚠️ No Brewfile found or Brewfile is empty. Skipping."
fi


# Install Node.js, npm, and Yarn via Volta
echo "📦 Ensuring Node.js, npm, and Yarn are installed via Volta..."
volta which node &>/dev/null || volta install node@18
volta which npm &>/dev/null || volta install npm@latest
volta which yarn &>/dev/null || volta install yarn@latest



# Set up symlinks
echo "🔗 Setting up symlinks..."
create_symlink() { # Define a function to create symlinks safely
    local source=$1
    local target=$2

    if [[ -L $target || -e $target ]]; then
        echo "🔄 Updating symlink: $target -> $source"
        ln -sf "$source" "$target"
    else
        echo "✅ Creating symlink: $target -> $source"
        ln -s "$source" "$target"
    fi
}

# Symlink dotfiles
create_symlink ~/dotfiles/.zshrc ~/.zshrc
create_symlink ~/dotfiles/.gitconfig ~/.gitconfig
create_symlink ~/dotfiles/.aliases ~/.aliases
# create_symlink ~/dotfiles/.exports ~/.exports


# Install VS Code extensions
if command -v code &>/dev/null; then
    echo "📦 Installing VS Code Extensions..."
    if [[ -f ~/dotfiles/vscode-extensions.txt ]]; then
        while IFS= read -r extension; do
            code --install-extension "$extension"
        done < ~/dotfiles/vscode-extensions.txt
    else
        echo "⚠️ No VS Code extensions file found. Skipping."
    fi
else
    echo "⚠️ VS Code not found. Skipping extension installation."
fi


echo "🚀 Setup complete!"
echo "🔄 Reloading shell..."
exec zsh