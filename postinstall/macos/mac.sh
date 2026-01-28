#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting macOS post-install setup..."

# --- System Settings ---

echo "Configuring macOS settings..."

# Enable soft click (Force Click) on trackpad
defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -bool true

# Enable right-click with two-finger tap
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Hide Dock and remove delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
killall Dock

# --- Developer Tools ---

# Install Xcode Command Line Tools
echo "Installing Xcode Command Line Tools..."
xcode-select --install || echo "Xcode Command Line Tools already installed."

# --- Homebrew Installation ---

if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew already installed."
fi

# --- Install Apps & Tools ---

echo "Installing Raycast..."
brew install --cask raycast

echo "Installing Ghostty..."
brew install --cask ghostty

echo "Installing Espanso..."
brew install --cask espanso
espanso start --unmanaged

echo "Installing Batfi..."
brew install --cask batfi

echo "Installing Obsidian"
brew install --cask obsidian

echo "Installing sioyek PDF"
brew install --cask sioyek --no-quarantine

echo "Installing Terminal Utilities and Programs..."
brew install wget tree fzf zoxide zk neovim pandoc macfuse go

# Install TinyTex
echo "Install TinyTex for Pandoc"
wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh

echo "Installing Git..."
brew install git
git config --global user.name "Sergio Barrera"
git config --global user.email "s.abrahambh@gmail.com"

echo "Installing Antidote Zsh Plugin Manager"
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

echo "Installing uv (Python manager) and Python..."
brew install uv
uv venv
uv pip install --upgrade pip
uv pip install python

# Or using the system package if you want latest Python via Homebrew directly:
# brew install python

echo "Installing NVM and latest Node.js..."
brew install nvm
mkdir -p ~/.nvm
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"' >> ~/.zshrc
echo '[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"' >> ~/.zshrc
source ~/.zshrc
nvm install node
npm i -g semantic-git-commit-cli
npm install -g typescript

echo "✅ Post-install setup complete."

