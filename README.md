# Nano Syntax Highlighting Setup Script

This script sets up `nano` with syntax highlighting on macOS. It requires Homebrew for installation.

## Prerequisites

- Homebrew installed on macOS

## Description

This script will:
1. Ensure `nano` is installed (using Homebrew if necessary).
2. Clean up any previous `nano` configuration.
3. Clone the `nanorc` repository for syntax highlighting.
4. Configure `nano` to use the syntax highlighting files.
5. Create a test Python file to verify the setup.

## Installation

1. **Clone the repository or create the script file**:

    ```sh
    git clone https://github.com/your-repo/nano-setup.git
    cd nano-setup
    ```

    Or create the script file directly:

    ```sh
    nano setup_nano_syntax.sh
    ```

2. **Copy the following script into `setup_nano_syntax.sh`**:

    ```sh
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
    ```

3. **Make the script executable**:

    ```sh
    chmod +x setup_nano_syntax.sh
    ```

4. **Run the script**:

    ```sh
    ./setup_nano_syntax.sh
    ```

## Usage

After running the script, you can verify that syntax highlighting is working by opening a file in `nano`, for example:

```sh
nano ~/test.py
```

If syntax highlighting is working, the script has successfully configured nano.

## Troubleshooting

If you encounter any issues, ensure that:

- Homebrew is installed and updated on your system.
- The script has the necessary permissions to execute.

For further assistance, please refer to the official nano documentation.

## License

This project is licensed under the MIT License - see the [LICENSE](/LICENSE) file for details.
