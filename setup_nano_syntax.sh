#!/bin/zsh

# Ensure nano is installed
if ! command -v nano &> /dev/null
then
    echo "Nano not found, installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Install nano on macOS using Homebrew
        brew install nano
    elif [[ -f /etc/debian_version ]]; then
        # Install nano on Debian/Ubuntu
        sudo apt-get update && sudo apt-get install -y nano
    elif [[ -f /etc/redhat-release ]]; then
        # Install nano on Fedora/Red Hat
        sudo dnf install -y nano
    else
        echo "Unsupported OS. Please install nano manually."
        exit 1
    fi
fi

# Clean up previous setup
rm -rf ~/.nano
rm -f ~/.nanorc

# Clone the nanorc repository
git clone https://github.com/scopatz/nanorc.git ~/.nano

# Create the .nanorc file with the correct include directive
echo 'include "~/.nano/*.nanorc"' > ~/.nanorc

# Ensure correct permissions for .nanorc and .nano directory
chmod 644 ~/.nanorc
chmod -R 755 ~/.nano
chmod 644 ~/.nano/*.nanorc

# Create a test Python file to check syntax highlighting
echo 'print("Hello, world!")' > ~/test.py

# Inform the user that the setup is complete
echo "Setup complete. Open ~/test.py with nano to check syntax highlighting."

# Open the test file in nano
nano ~/test.py
