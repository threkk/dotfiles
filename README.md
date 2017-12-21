# dotfiles

Personal configuration for several softwares. Described here to have an easy way
to install and configure my developmed environment.

It includes the configuration for:

- Vim/NeoVim.
- zsh (Oh-my-zshrc)
- Git
- TMUX
- Devdocs
- NPM
- Brew
- Python
- Tern.js
- iTerm2
- ... and other tools and scripts.

## Setup
*Assuming that `vim`, `zsh`, `git`, `oh-my-zsh` and `brew` are installed.*   
Clone the repository in `~/.dotfiles` and link the configuration files.
```
git clone https://github.com/threkk/dotfiles.git ~/.dotfiles
```

### Vim
It will give an error, ignore and press `ENTER`.
```
ln -s ~/.dotfiles/vim ~/.config/nvim
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/init.vim ~/.vimrc
mkdir -p ~/.config/vim-tmp
vim +PlugInstall
:PlugInstall
```

### Oh-my-zsh
```
mv ~/.zshrc ~/.zshrc.old
ln -s ~/.dotfiles/zshrc ~/.zshrc
``` 

### Git
Maybe you need to update your `gpg` binary. 
```
mv ~/.gitcofing ~/.gitconfig.old
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
```

### TMUX
```
mv ~/.tmux.conf ~/.tmux.conf.old
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
```

### NPM
```
mkdir ~/.npm-packages
ln -s ~/.dotfiles/npmrc ~/.npmrc
```

### Tern.js
```
ln -s ~/.dotfiles/tern-project.json ~/.tern-config
ln -s ~/.dotfiles/tern-project.json ~/.tern-project
```

### Devdocs
Import the configuration file (`devdocs.json`) in the
[Devdocs](https://devdocs.io) website.

### Scripts
`scripts` is a [little project of mine](https://github.com/threkk/scripts).
I compile useful scripts I find or create. There are several of them that I find
useful to have them in my path, but it implies to keep it updated.

To solve this issue, the configurations loads a folder `~/.scripts` in which I
place or link my scripts.

## Software
This is a selection of the software I use daily wich configuration is also
included in this repository. The following list provides an easy way to install
them all.
```
brew tap neovim/neovim 
brew tap beeftornado/rmtree
brew tap karan/karan
brew tap universal-ctags/homebrew-universal-ctags

brew install node go python python3 ruby tmux ccat diff-so-fancy neovim vim \
    git hub httpie fzf the_silver_searcher dep sqlite joe zsh-autosuggestions \ 
    zsh-completions zsh-syntax-highlighting cmake exercism

brew install --HEAD universal-ctags/universal-ctags/universal-ctags

npm install -g standard csslint js-yaml n node-debug typescript vue-cli gtop \
    surge ternjs documentation neovim tldr

npm install -g https://github.com/ramitos/jsctags.git

pip2 install neovim
pip3 install jedi pep8 pipenv requests neovim
gem install neovim
```

## License
BSD-3 (c) Alberto Martinez de Murga Ramirez
