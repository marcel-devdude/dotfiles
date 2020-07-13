# dotfiles

## Installation

Install Homebrew:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Install Oh My Zsh:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install dependencies:

```
brew install git
brew install python python3 neovim fzf the_silver_searcher watchman nvm yarn ranger tmux reattach-to-user-namespace tmuxinator

nvm install 12.13.1

pip3 install neovim
gem install neovim
npm install -g neovim typescript
```

Clone this repository and get submodules:

```
git clone git@github.com:marcel-devdude/dotfiles.git
git submodule init
git submodule update
```

Install VimPlug:

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Create symlinks:

```
ln -sv ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -sv ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sv ~/dotfiles/zsh/plugins/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ln -sv ~/dotfiles/zsh/plugins/dracula-theme/dracula.zsh-theme ~/.oh-my-zsh/custom/themes/dracula.zsh-theme
ln -sv ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sv ~/dotfiles/tmuxinator ~/.config/tmuxinator
ln -sv ~/dotfiles/nvim ~/.config/nvim
ln -sv ~/dotfiles/ranger ~/.config/ranger
ln -sv ~/dotfiles/ssh ~/.ssh
```

Install Fonts:

```
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

git clone https://github.com/ryanoasis/nerd-fonts.git --depth 1
cd nerd-fonts
./install.sh
cd ..
rm -rf nerd-fonts
```

Install Vim Plugins:

In VIM run `:PlugInstall`

Import xterm profile: `xterm-profile.json`


## Resources

- [How to create custom tmuxinator layout]( https://fabianfranke.de/use-tmuxinator-to-recreate-tmux-panes-and-windowstmuxinator-save-tmux-pane-and-window-layouts/)
