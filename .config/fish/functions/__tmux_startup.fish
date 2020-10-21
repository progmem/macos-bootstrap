function __tmux_startup --description 'Auto-start tmux'
  # If I'm not in a tmux session, enter one.
  if test -z "$TMUX"
    # While we should never hit this for loop, if a tmux session isn't available I want to make sure we attach to an existing one before creating a new one.
    for session in (tmux ls 2>/dev/null | grep -vi "attached" | cut -d: -f1)
    # If we successfully attach to a session, exit 0 will prevent us from going any further.
      tmux attach -t $session && return 0
    end
    # If we didn't have a session to attach to, start a new one.
    tmux && return 0
  end
  return 1
end
