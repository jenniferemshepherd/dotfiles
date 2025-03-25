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
# 1️⃣ Check if the SSH key already exists
ls -l ~/.ssh/id_ed25519_work

# 2️⃣ Generate a new SSH key (for work)
ssh-keygen -t ed25519 -C "your.work.email@example.com" -f "$HOME/.ssh/id_ed25519_work" -N ""

# 3️⃣ Start the SSH agent
if [[ -z "$(pgrep ssh-agent)" ]]; then
    eval "$(ssh-agent -s)"
fi

# 4️⃣ Add the new work key to the SSH agent and apple keychain to persist across sessions
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_work

# 5️⃣ Copy the public key to clipboard (for GitHub)
pbcopy < ~/.ssh/id_ed25519_work.pub

# 6️⃣ Add the key to GitHub manually
# Go to: https://github.com/settings/keys
# Click "New SSH Key" and paste the key

# 7️⃣ Test the SSH connection with GitHub
ssh -T -v git@github.com  # Verbose mode helps debug issues

```

### 3️⃣ Clone dotfiles repo
```
git clone git@github.com:jenniferemshepherd/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

<!-- something about permissions
sudo chown -R jennifer.shepherd:admin /opt/homebrew
ls -ld /opt/homebrew
 to verify
 sudo chmod -R u+rwX /opt/homebrew
now i own brew!
 -->


### 4️⃣ Run setup script
```
chmod +x setup.sh
su engadmin  # Switch to an admin account
setup-admin.sh
exit  # Go back to normal user
./setup.sh
```

---

## ✨ What the set up script will do

setup-admin.sh
- installs homebrew under admin perms
- installs the contents of Brewfile

setup.sh
- sets path
- uses Volta to install node, npm, yarn
- installs oh my zsh and autosuggestions plugin
- creates symlinks
- installs vscode extensions
- loads .zshrc

### Some pointers on maintaining your dotfiles:

- When installing a new app, tool or font, try to install it with Homebrew and add it to your Brewfile
- When configuring a new app make sure to run mackup backup to save your preferences
- When changing an macOS setting, try setting it through the .macos file
- Always save documents through a cloud storage like iCloud, Dropbox, or something else
- If you follow these pointers you'll definitely make sure that your Mac will be restored the way you left it the next time you need to re-install.