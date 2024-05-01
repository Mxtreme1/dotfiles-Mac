#!/bin/sh

#WITH_FFMPEG=false
#WITH_ANKI=false

LOAD_ONLY=false

usage() {
    echo "Usage: $0 --help | --load-only | --full | --with-ffmpeg | --with-anki"
    exit 1
}

print_cyan() {
    CYAN='\033[0;36m' # CYAN
    NC='\033[0m' # No Color
    echo "${CYAN}$@${NC}"
}

if [ "$1" = "--full" ]; then
    WITH_FFMPEG=true
    WITH_ANKI=true
else
    while [ ! "$1" = "" ]; do
        if [ "$1" = "--help" ]; then
            usage
            exit 1
        elif [ "$1" = "--with-ffmpeg" ]; then
            WITH_FFMPEG=true
        elif [ "$1" = "--with-anki" ]; then
            WITH_ANKI=true
        elif [ "$1" = "--load-only" ]; then
            LOAD_ONLY=true
        fi
        shift
    done
fi

if [[ -z "$XDG_CONFIG" ]]; then
    XDG_CONFIG="$HOME/.config"
fi

# git {{{ #

git_(){
    print_cyan "Installing git.." 
    brew install git
}
# }}} git #

# CMake {{{ #

cmake_() {
    print_cyan "Installing cmake..." 
    brew install cmake
}

# }}} CMake #

# Neovim {{{ #
neovim_() {
    print_cyan "Installing neovim.." 
    brew install neovim

    # VIM CONFIG {{{ #

    print_cyan "Configuring neovim..." 
    cp "vim/vimrc" "$HOME/.vimrc"
    cp "vim/nvim" "$HOME/.config"

    mkdir -p "$HOME/vim/bundle"
    git clone "https://github.com/VundleVim/Vundle.vim.git" "$HOME/vim/bundle/Vundle.vim"
    nvim +PluginInstall

    # }}} VIM CONFIG #

}
# }}} Vim #

# ZSH {{{ #
zsh_() {
    print_cyan "Installing zsh.." 
    brew install zsh

    # ZSH-CONFIG {{{ #

    print_cyan "Configuring zsh..." 
    cp "zsh/zshrc" "$HOME/.zshrc"

    mkdir "$HOME/.zsh" &&
    cp zsh/*.zsh "$HOME/.zsh"

    # TODO: Allow multiple retries for this command (in case pw/user is wrong)
    print_cyan "Making zsh default shell..." 
    chsh -s $(which zsh)  # make zsh default shell

    # Install Oh My ZSH
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Nerdfonts used for oh my zsh and powerlevel10k
    print_cyan "Installing Nerdfonts..." 
    brew tap homebrew/cask-fonts
    brew install font-hack-nerd-font

    # Powerlevel10k
    print_cyan "Installing PowerLevel10k..." 
    brew install powerlevel10k
    echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc  # Activate by adding to end of .zshrc
    cp zsh/PowerLevel10k/* "$Home"
    exec zsh
    # }}} ZSH-CONFIG #
}

# }}} ZSH #

# Ripgrep-Search {{{ #
ripgrep_() {
    print_cyan "Installing ripgrep..." 
    brew install ripgrep
}

# }}} Ripgrep-Search #

# Python {{{ #

python_() {
    print_cyan "Installing python..." 
    brew install python
    sudo pip install --upgrade pip
    sudo pip3 install --upgrade pip

    print_cyan "Installing basic python packages: numpy, scipy, pytorch"
    sudo pip install numpy
    sudo pip install scipy
    sudo pip install sklearn
    sudo pip install pytorch
}

# }}} Python #

# Latex {{{ #
latex_() {
    print_cyan "Installing latex..." 
    brew install --cask mactex
}
# }}} Latex #

# Music {{{ #
ffmpeg_(){

    print_cyan "Installing ffmpeg..." 
    brew install ffmpeg
}

# }}} Music #

mas_(){
    print_cyan "Installing mas (Mac AppStore CLI downloader)..."
    brew install mas
}

one_password_(){
    print_cyan "Installing 1Password..."
    curl "https://downloads.1password.com/mac/1Password.zip" -o ~/Downloads/1Password.zip
    unzip ~/Downloads/1Password.zip
    rm ~/Downloads/1Password.zip
}

mac_for_coders_keyboard_(){
    print_cyan "Installing the German-For-Coders keyboard I created..."
    mkdir ~/Documents/git/github
    cd ~/Documents/git/github
    git clone https://github.com/Mxtreme1/German-for-Coders-Mac-Keyboard.git
    cp German-For-Coding.bundle /Library/Keyboard\ Layouts
}

iterm2_(){
    print_cyan "Installing iTerm2..."
    curl "https://iterm2.com/downloads/stable/latest" -o ~/Downloads/iTerm2.zip
    cd ~/Downloads
    unzip iTerm2.zip
    rm iTerm2.zip
}

firefox_(){
    print_cyan "Installing Firefox..."
    brew install --cask firefox
}

rectangle_(){
    print_cyan "Installing Rectangle..."
    brew install --cask rectangle
}

middle_click_(){
    print_cyan "Installing Middle Click..."
    brew install --cask middleclick
}

vlc_(){
    print_cyan "Installing VLC..."
    brew install --cask vlc
}

base_install() {
    git_
    cmake_
    neovim_
    zsh_

    ripgrep
    python_
    latex_
    ffmpeg_
    mas_
    one_password_
    mac_for_coders_keyboard_
    iterm2_
    firefox_
    rectangle_
    middle_click_
    vlc_


    print_cyan "Installations Complete!"
    print_cyan "Things left to do:"
    print_cyan "-Install 1Password from Download folder"
    print_cyan "-Install iTerm2 from Download folder"
    print_cyan "-Install German-For-Coders-Keyboard by logging out and in again and choosing it in keyboard settings"

}

#if [ $LOAD_ONLY = false ]; then
    #base_install

    #if [ $WITH_MOCP = true || $WITH_FFMPEG = true ]; then
        #music_
    #fi

    #if [ $WITH_ANKI = true ]; then
        #anki_
    #fi

    #if [ $WITH_OCAML = true ]; then
        #ocaml_
    #fi
#fi
