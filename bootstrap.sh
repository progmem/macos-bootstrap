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
