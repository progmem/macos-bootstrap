# This function will read in the declared Ruby version of a Gemfile and tell RVM
# to switch to the appropriate version of Ruby.

# Make sure to install the Fish functions from https://rvm.io/integration/fish .
# Do -not- add the 'rvm default' statement to your config.fish, however.
# Instead of adding 'rvm default' add a call to this function instead.

function check_rvm --on-variable PWD
  set __gemfile_location "$PWD"
  
  while true
    if test "$__gemfile_location" = "$__current_gemfile_location"
      return
    else if ! test -e "$__gemfile_location/Gemfile"
      set __gemfile_location (realpath "$__gemfile_location/..")
      
      if test "$__gemfile_location" = '/'
        if set -q __current_gemfile_location
          rvm use default ^/dev/null
          set -e __current_gemfile_location
        end
        return
      end
    else
      set -g __current_gemfile_location "$__gemfile_location"
      rvm use "$__current_gemfile_location"
      return
    end
  end
end

