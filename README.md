# Jennifer's Dotfiles

## What Is This?

This repository is my way to help me setup and maintain my Mac. It takes the effort out of installing everything manually. Everything which is needed to install my preffered setup of OS X is detailed in this readme.


## 🛠 Setting Up a New Mac to clone these files

If you're setting up a **new Mac** follow these steps **before cloning your dotfiles**.

### 1️⃣ Install Git & SSH
`xcode-select --install`

### 2️⃣ Set up SSH authentication

N.B. If your default SSH settings are not for work, replace `work` with `personal` in these steps.

```
// Check if (work) SSH key exists
ls -l ~/.ssh/id_ed25519_work
// Generate new key (for work)
ssh-keygen -t ed25519 -C "your.work.email@example.com" -f "$HOME/.ssh/id_ed25519_work" -N ""
// Start  SSH agent
eval "$(ssh-agent -s)"
Add new (work) key to the SSH agent
ssh-add ~/.ssh/id_ed25519_work
// Copy the public key to clipboard (for GitHub)
pbcopy < ~/.ssh/id_ed25519_work.pub
// Add the key to GitHub and test the connection
ssh -T git@github.com
// Ensure Git uses SSH instead of HTTPS by default
git config --global url."git@github.com:".insteadOf "https://github.com/"
```

### 3️⃣ Clone dotfiles repo
```
git clone git@github.com:jenniferemshepherd/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 4️⃣ Run setup script
`chmod +x setup.sh`
`./setup.sh`

---

## ✨ What the set up script will do

### Some pointers on maintaining your dotfiles:

- When installing a new app, tool or font, try to install it with Homebrew and add it to your Brewfile
- When configuring a new app make sure to run mackup backup to save your preferences
- When changing an macOS setting, try setting it through the .macos file
- Always save documents through a cloud storage like iCloud, Dropbox, or something else
- If you follow these pointers you'll definitely make sure that your Mac will be restored the way you left it the next time you need to re-install.