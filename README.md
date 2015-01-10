#vim-setup
My vim configuration with all the plugins I use.

If you want to use the same configuration:

```
mv .vim .vim.old
mv .vimrc .vimrc.old
git clone https://github.com/threkk/vim-setup.git
mv vim-setup .vim
ln .vim/vimrc.txt .vimrc
```
To install all the plugins and themes, you need to use Plug.

Open vim (it will give an error, press ENTER) and type:
```
:PlugInstall
```

To read the complete [Plug commands](https://github.com/junegunn/vim-plug).

License: MIT
