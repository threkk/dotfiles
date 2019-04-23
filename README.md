# dotfiles

Personal configuration for several softwares. Described here to have an easy way

to install and configure my developmed environment.
It includes the configuration for:

- Vim/NeoVim.
- Brew
- TMUX
- zsh 
- Git
- JavaScript
- Python
- Golang
- Alacritty
- ... and other tools and scripts.
## Setup
### Pre requisites
> `brew` and `oh-my-zsh` must be installed beforehand.
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
ln -s ~/.dotfiles/coc ~/.config/coc
mkdir -p ~/.config/vim-tmp
vim +PlugInstall
```

### Oh-my-zsh
```
mv ~/.zshrc ~/.zshrc.old
``` 
ln -s ~/.dotfiles/zshrc ~/.zshrc

### Git
Maybe you need to update your `gpg` binary. 
```
mv ~/.gitcofing ~/.gitconfig.old
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
```

### TMUX
```
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
mv ~/.tmux.conf ~/.tmux.conf.old
```

### Prettier
```
ln -s ~/.dotfiles/prettierrc.json .prettierrc
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

brew install node go python python2 ruby tmux ccat diff-so-fancy neovim vim \
    git hub httpie fzf the_silver_searcher dep sqlite zsh-autosuggestions \ 
    zsh-completions zsh-syntax-highlighting yarn pipenv

yarn global add prettier sslint js-yaml typescript vue-cli gtop \
    surge neovim tldr bash-language-server fkill-cli jsonlint 

npm install -g https://github.com/ramitos/jsctags.git

pip2 install pynvim
pip3 install jedi flake8 requests pynvim python-language-server
gem install neovim
```

## License
BSD-3 (c) Alberto Martinez de Murga Ramirez
