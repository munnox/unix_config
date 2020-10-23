#!/bin/bash
# Source <https://www.rust-lang.org/tools/install>
# Install Docker CE on linux

function install_rust() {
    # useful programs
    # sudo apt install git tmux neovim gcc
    # Required program
    sudo apt install curl
    curl https://sh.rustup.rs -sSf | sh
}

function install_alacritty {
    # Original source https://gist.github.com/Aaronmacaron/8a4e82ed0033290cb2e12d9df4e77efe
    #!/bin/bash
    sudo snap install alacritty --edge --classic

    # This installs alacritty terminal on ubuntu (https://github.com/jwilm/alacritty)
    # You have to have rust/cargo installed for this to work

    # Install required tools
    sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

    # Download, compile and install Alacritty
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
    cargo build --release
    cargo install

    # Add Man-Page entries
    sudo mkdir -p /usr/local/share/man/man1
    gzip -c alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

    # Terminfo
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

    # Add shell completion for bash and zsh
    mkdir -p ~/.bash_completion
    cp alacritty-completions.bash ~/.bash_completion/alacritty
    echo "source ~/.bash_completion/alacritty" >> ~/.bashrc

    # Copy default config into home dir
    cp alacritty.yml ~/.alacritty.yml

    # Create desktop file
    cp Alacritty.desktop ~/.local/share/applications/

    # Copy binary to path
    sudo cp target/release/alacritty /usr/local/bin

    # Use Alacritty as default terminal (Ctrl + Alt + T)
    gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

    # # Remove temporary dir
    # cd ..
    # rm -r alacritty

}

