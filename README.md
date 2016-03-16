# dotfiles
half-shell's personnal configuration

## Description
This repo is just a versionning solution of the config i'm currently using. I'll keep it
up to date since it's the config files i'm using all the time. My main workspace is Arch Linux based, and i am using Awesome WM as my windows manager.

## Get started
All you need to do is
```bash
git clone --recursive https://github.com/half-shell/dotfiles.git dotfiles/
```
and you're good to go, assuming you know you already know your way around those dotfiles. Either way, i recommend reading further, since it gets easier with stow.

## GNU Stow
I recommend using GNU Stow as a way to manage you're dotfiles per environnement. It doesn't get more complicated that doing
```bash
cd ~/dotfiles
```
and then, depending on the application you want to get the config from, for example for vim, just do a
```bash
stow vim
```
That's all!

Even better, i created an alias in my .bashrc so i don't have to cd in my dotfiles directory.
```bash
alias stow='stow -d path/to/dotfiles'
```

## Awesome config
#### ToDos
* Theming (in particulary regarding the color of borders)
* Considering using lain library to add extra layouts
* Widgets

## Vim config
It is advised to read the config file heavily commented so you can understand what is going on.
#### Advisory
Be also aware that vim is configured to gather the swap files in the ~/.tmp directory, which you have to create. Keep in mind that if you don't, vim won't produce any swap file.
#### Plug-in manager
I'm using [vim-plug] as my plugin manager, since Vundle is not maintained anymore, and updates/installations aren't done as quickly.
[vim-plug] is managed as a git submodule of my dotfiles, and  will be kept updated that way.
To get all that vim plugin goodness going, all you have to do is get into vim and do a 
```
:PlugInstall
```
For more information about vimplug and how to manage your plugins, just head to [vim-plug].
#### ToDos
* ~~Add support for plugins~~
* autocompletion (YouCompleteMe?)
* search utility (FZF?)
* indent

##### Plugins
* lightline (status line)
* auto-pairs (autoclose surrounders)

##Bash config

##Termite config
#### ToDos
* Change font (maybe)

## IRSSI config

[vim-plug]: https://github.com/junegunn/vim-plug
