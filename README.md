# dotfiles

A collection with all the dotfiles and plugins I use. The branch of this
repository contains the configuration for:

- Vim
- Oh-my-zshrc
- Git
- Tern.js
- iTerm2
- TMUX

... and many other tools.

If you want to use the same configuration, execute the following commands on
your root directory:

```
git clone https://github.com/threkk/dotfiles.git ~/.dotfiles
```
## List of software required.
These tools also require to have installed brew, Python, Golang and Node.js.
- [Vim](https://github.com/vim/vim)/[NeoVim](https://github.com/neovim/neovim)
- [Git](https://github.com/git/git)
- [TMUX](https://github.com/tmux/tmux)
- [Hub](https://github.com/github/hub)
- [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [HTTPie](https://httpie.org/)
- [FZF](https://github.com/junegunn/fzf)
- [The silver searcher](https://github.com/ggreer/the_silver_searcher)
- [Tern.js](https://github.com/ternjs/tern)
- [CTags](http://ctags.sourceforge.net/)+[JSCTags](https://github.com/ramitos/jsctags)
- [Standard](https://standardjs.com/)
- [PEP8](https://pypi.python.org/pypi/pep8)
- [Jedi](https://github.com/davidhalter/jedi)

## Installation details.
### Vim
To install all the plugins and themes, you need to use Plug.

Open vim (it will give an error, press ENTER) and type:
```
ln -s ~/.dotfiles/vim ~/.config/vim
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/init.vim .~/vimrc
mkdir ~/.config/vim-tmp
vim +PlugInstall
:PlugInstall
```
To read the complete [Plug commands](https://github.com/junegunn/vim-plug).
### Oh-my-zsh
After intalling `oh-my-zsh`, run the following command:
```
mv ~/.zshrc ~/.zshrc.old
ln -s ~/.dotfiles/zshrc ~/.zshrc
```
### Git
```
mv ~/.gitcofing ~/.gitconfig.old
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
```
### Tern.js
After installing `tern.js`, run the following command:
```
ln -s ~/.dotfiles/tern-project.json ~/.tern-config
ln -s ~/.dotfiles/tern-project.json ~/.tern-project
```

## Recommended software
Not really necessary, but useful:
- [n](https://github.com/tj/n)
- [node-inspector](https://github.com/node-inspector/node-inspector)
- [Diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- [mosh](https://mosh.org)
- [ccat](https://github.com/jingweno/ccat)

License: MIT
