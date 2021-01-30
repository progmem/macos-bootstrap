#!/usr/bin/env bash


### Download Homebrew
if ! which -s brew; then
  echo "Homebrew not present, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi


### Install Homebrew bundle
if which -s brew; then
  echo "Homebrew present!"
  brew bundle
fi


### Install Other Components
# RVM
echo "Grabbing GPG keys for RVM..."
curl -sSL https://rvm.io/mpapis.asc     | gpg --import -
echo 409B6B1796C275462A1703113804BB82D39DC0E3:6: | gpg --import-ownertrust
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
echo 7D2BAF1CF37B13E2069D6956105BD0E739499BDB:6: | gpg --import-ownertrust
echo "Installing RVM..."
curl -sSL https://get.rvm.io | bash -s stable


### Change shell
# Thanks to https://github.com/thoughtbot/laptop/issues/447
set_login_shell_macos() {
  local new_shell="$1"
  local current_shell="$(dscl . read "$HOME" UserShell 2>/dev/null | cut -d" " -f2)"

  if [ -z "$current_shell" ]; then
    echo "Setting shell to $new_shell..."
    sudo dscl . create "$HOME" UserShell "$new_shell"
  elif [ "$current_shell" = "$new_shell" ]; then
    echo "Using $new_shell"
    return
  else
    echo "Updating shell from $current_shell to $new_shell..."
    sudo dscl . change "$HOME" UserShell "$current_shell" "$new_shell"
  fi
}

set_login_shell_macos /usr/local/bin/fish


### Symlink .config
rm -rf "$HOME/.config" && ln -sFfn "$(pwd)/.config" "$HOME/.config"
