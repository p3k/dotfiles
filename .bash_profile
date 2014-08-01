# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * `globstar`, recursive globbing, e.g. `echo **/*.txt`
# FIXME: globstar compromises both features :/
for option in autocd; do
  shopt -s "$option" 2> /dev/null
done

# Add tab completion for Bash commands and MacPorts binaries
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

# Enable tab completion for `g` by marking it as an alias for `git`
# FIXME: Does not work :/
if type __git_main &> /dev/null; then
  complete -o default -o nospace -F __git_complete g __git_main
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# Load virtualenvwrapper
#export WORKON_HOME=~/.virtualenvs
. /opt/local/bin/virtualenvwrapper.sh-2.7

# Load Node Version Manager
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh
