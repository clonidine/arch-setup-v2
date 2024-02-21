PACKAGES=('alacritty' 'kitty' 'i3' 'vscodium-bin' 'rust' 'flameshot' 'tor-browser-bin' 'lua' 'keepassxc' 'feh')

DEFAULT_CONFIG_PATH=~/.config
DEFAULT_WALLPAPERS_PATH=~/Documents/Wallpapers

DOTFILES_REPOSITORY='https://github.com/clonidine/.dotfiles.git'
DOTFILES_DIRECTORY_NAME='.dotfiles'

WALLPAPERS_DIRECTORY_NAME=${DOTFILES_DIRECTORY_NAME}'/wallpapers'
CONFIG_DIRECTORY_NAME=${DOTFILES_DIRECTORY_NAME}'/.config'

YAY_GIT='https://aur.archlinux.org/yay.git'

FONTS=('https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip', 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip')
FONTS_DEFAULT_PATH=/usr/share/fonts

TEMP_FONT_PATH=/tmp/fonts

CreateDirectory () {
  mkdir -p $1
}

CloneRepository () {
  git clone $1
}

CopyTo () {
  cp -r $1/* $2/
}

InstallYay () {
  (CloneRepository $YAY_GIT && cd yay && makepkg -si)
}

InstallPackages () {
  for package in "${PACKAGES[@]}"
  do
    yay -S $package
  done
}

InstallWallpapers () {
  CreateDirectory $DEFAULT_WALLPAPERS_PATH
  CopyTo $WALLPAPERS_DIRECTORY_NAME $DEFAULT_WALLPAPERS_PATH
}

InstallDotfiles () {
  CreateDirectory $DEFAULT_CONFIG_PATH
  CopyTo $CONFIG_DIRECTORY_NAME $DEFAULT_CONFIG_PATH
}

InstallYay
InstallPackages

CloneRepository $DOTFILES_REPOSITORY

InstallWallpapers
InstallDotfiles
