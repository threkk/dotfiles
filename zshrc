# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="norm"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in $HOME/.oh-my-zsh/plugins/*)
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew common-aliases docker gitfast git-extras github httpie npm osx pip python web-search z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Ensure correct SHELL version
[ -z "$ZSH_VERSION" ] || export SHELL="/bin/zsh"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# SSH
export SSH_KEY_PATH="${HOME}/.ssh/id_rsa"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate $HOME/.zshrc"
# alias ohmyzsh="mate $HOME/.oh-my-zsh"
#

# Extra config
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export HOMEBREW_NO_ANALYTICS=1
export PYTHONDONTWRITEBYTECODE=1
export XDG_CONFIG_HOME=$HOME/.config
export GPG_TTY="$(tty)"
export PIPENV_VENV_IN_PROJECT=1
export GO111MODULE=on
export GOPATH=$HOME/.go
export DISPLAY=:0
export DOCKER_HOST="tcp://localhost:2375"
export NVM_DIR="$HOME/.nvm"

PLATFORM='unknown'
if [[ `uname` == 'Linux' ]]; then
  PLATFORM='linux'
elif [[ `uname` == 'Darwin' ]]; then
  PLATFORM='osx'
fi
export PLATFORM


if [[ $PLATFORM == 'linux' ]]; then 
  BREW_PATH='/home/linuxbrew/.linuxbrew'
elif [[ $PLATFORM == 'osx' ]]; then
  BREW_PATH='/usr/local'
fi
export BREW_PATH

# Exports
[ -f $HOME/.dotfiles/exports.sh ] && source $HOME/.dotfiles/exports.sh

# Path
export PATH=$BREW_PATH/sbin:$PATH
export PATH=$BREW_PATH/bin:$PATH
export PATH=$BREW_PATH/opt/python@2/bin:$PATH
export PATH=$BREW_PATH/opt/python/libexec/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=`yarn global bin`:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$HOME/.bin:$PATH
[ -s $BREW_PATH/opt/nvm/nvm.sh ] && . $BREW_PATH/opt/nvm/nvm.sh 

# Tools
source $HOME/.dotfiles/tools.sh
[ ! -d "$HOME/.bin" ] && mkdir -p $HOME/.bin

# Dircolors
[ -f $HOME/.dir_colors ] && eval `dircolors $HOME/.dir_colors`

# Auto completation
command -v hub > /dev/null 2>&1 && eval "$(hub alias -s)"
command -v pipenv > /dev/null 2>&1 && eval "$(pipenv --completion)"
[ -s $BREW_PATH/opt/nvm/etc/bash_completion ] && . $BREW_PATH/opt/nvm/etc/bash_completion  
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.iterm2_shell_integration.zsh ] && source $HOME/.iterm2_shell_integration.zsh
[ -f $BREW_PATH/share/zsh-syntax-highlighting.zsh ] && source $BREW_PATH/share/zsh-syntax-highlighting.zsh
[ -f $BREW_PATH/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $BREW_PATH/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=($BREW_PATH/share/zsh-completions $fpath)

if [ "$(umask)" = "0000" ]; then
  umask 0022
fi
