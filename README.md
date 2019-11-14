# dotfiles

Personal configuration for several softwares. Described here to have an easy way
### Pre requisites
> `brew` and `oh-my-zsh` must be installed beforehand.

Clone the repository in `~/.dotfiles` and link the configuration files.
```
git clone https://github.com/threkk/dotfiles.git ~/.dotfiles
```

### `config` folder
```
ln -s ~/.dotfiles/config ~/.config
```

### ZSH
```
ln -s ~/.dotfiles/zshrc ~/.zshrc
``` 

### Git
Maybe you need to update your `gpg` binary. 
```
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
```

### TMUX
```
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/tmux.d ~/.tmux.d
```

### Prettier
```
ln -s ~/.dotfiles/prettierrc.json .prettierrc
```

### `dir_colors`
```
ln -s ~/.dotfiles/dir_colors .dir_colors
```

### Scripts
`scripts` is a [little project of mine](https://github.com/threkk/scripts).
I compile useful scripts I find or create. There are several of them that I find
useful to have them in my path, but it implies to keep it updated.

To solve this issue, the configurations loads a folder `~/.bin` in which I
place or link my scripts.

## Software
Different CLI applications that I use as part of my daily flow.
```
brew bundle
npm install -g prettier csslint js-yaml typescript neovim tldr jsonlint 
python3 -m pip install --user pipx pynvim
pipx install poetry
gem install neovim
```

## License
BSD-3 (c) Alberto Martinez de Murga Ramirez
