# Add `~/bin` to the `$PATH`
PATH="/home/emmett/.local/bin:$PATH" 
PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="/usr/local/CELLAR:$PATH"
PATH="/usr/local/mysql/bin:$PATH"
PATH="~/.npm-packages/lib:$PATH"
PATH="~/.npm/bin:$PATH"
LDFLAGS="-L/usr/local/opt/readline/lib"
HOMEBREW_NO_ENV_FILTERING=1
CPPFLAGS="-I/usr/local/opt/readline/include"
NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

SSH_ENV="$HOME/.ssh/environment"
function start_agent {
    ssh-agent > "$SSH_ENV"
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}

#export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages
export PYTHONPATH=$PYTHONPATH:/usr/local/bin/python2.7/site-packages

# # set where virutal environments will live
# export WORKON_HOME=$HOME/.virtualenvs
# # ensure all new environments are isolated from the site-packages directory
# export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
# # use the same directory for virtualenvs as virtualenvwrapper
# export PIP_VIRTUALENV_BASE=$WORKON_HOME
# # makes pip detect an active virtualenv and install to it
# export PIP_RESPECT_VIRTUALENV=true
# if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
#     source /usr/local/bin/virtualenvwrapper.sh
# else
#     echo "WARNING: Can't find virtualenvwrapper.sh"
# fi
# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

 if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
     source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
 fi
# Add tab completion for many Bash commands
# if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
#   source "$(brew --prefix)/etc/bash_completion";
# elif [ -f /etc/bash_completion ]; then
#   source /etc/bash_completion;
# fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/emmettfaricy/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/emmettfaricy/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/emmettfaricy/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/emmettfaricy/Downloads/google-cloud-sdk/completion.bash.inc'; fi
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
eval "$(pyenv init -)"

export NVM_HOME=/Users/emmettfaricy/.nvm

export PATH=${PATH}:${NVM_HOME}

source ${NVM_HOME}/nvm.sh
