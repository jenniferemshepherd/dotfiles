#!/bin/zsh

set -e  # Exit immediately if any command fails

export HOME="/Users/jennifer.shepherd"
echo "🏠 HOME is now set to: $HOME"
echo "🔍 PATH is: $PATH"
whoami

# Check if HOME is correctly set
if [[ "$HOME" != "/Users/jennifer.shepherd" ]]; then
    echo "❌ ERROR: HOME is not set correctly!"
    exit 1
fi


# Ensure Volta's bin is in PATH
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:/opt/homebrew/bin:$PATH"

# Install Node.js, npm, and Yarn via Volta
echo "📦 Ensuring Node.js, npm, and Yarn are installed via Volta..."
volta which node &>/dev/null || volta install node@18
volta which npm &>/dev/null || volta install npm@latest
volta which yarn &>/dev/null || volta install yarn@latest


# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🛠 Installing Oh My Zsh..."
    # this makes sure we don't change the shell to zsh immediately, so the script can continue
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
        echo "❌ Oh My Zsh installation failed!"
        exit 1
    }
else
    echo "✅ Oh My Zsh is already installed."
fi

# Ensure Oh My Zsh custom plugins directory exists
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Install zsh-autosuggestions plugin if missing
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "📥 Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "✅ zsh-autosuggestions is already installed."
fi


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
exec zsh -l && source ~/.zshrc
