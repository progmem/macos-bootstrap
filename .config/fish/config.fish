set -g fish_user_paths "/usr/local/opt/util-linux/bin"  $fish_user_paths
set -g fish_user_paths "/usr/local/opt/util-linux/sbin" $fish_user_paths
set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths

# Handle tmux checks first
__tmux_startup

eval (starship init fish)

for src in (find ~/.config/fish/config -name '*.fish')
  source $src
end

# RVM Gemfile actuation
rvm reload && check_rvm

set VISUAL 'nano'
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
