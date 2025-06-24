#!/bin/bash
# https://github.com/lvntcnylmz/dotfiles
if [[ "${UID}" != 0 ]] ; then
  echo -e "please run this script as with root privileges:\n\tsudo bash ./install.sh"
  exit 1
fi

set -e
packages=(
  foot
  waybar
  ly
  neovim
  fish
  fuzzel
  yazi
  starship
  swaync
  fastfetch
  btop
)

for pkg in "${packages[@]}"; do
  if pacman -Q "$pkg" &>/dev/null; then
    echo "[✓] $pkg is already installed."
  else
    echo "[+] Installing $pkg..."
    pacman -S --noconfirm "$pkg"
  fi
done

# install other packages
if ! pacman -Q swaylock-effects &>/dev/null; then
  echo "[+] Installing swaylock-effects manually from AUR..."
  git clone https://aur.archlinux.org/swaylock-effects.git
  cd swaylock-effects
  makepkg -si --noconfirm
  cd ..
  rm -rf swaylock-effects
else
  echo "[✓] swaylock-effects is already installed."
fi

if [ -d ".config" ] && [ -d "$HOME/.config" ]; then
  echo "[+] Copying config files from ./config to ~/.config..."
  cp -rn .config/* ~/.config/
else
  echo "[!] Either local '.config' or '~/.config' folder not found. Skipping config copy."
fi

echo -e "\nInstallation completed!"
