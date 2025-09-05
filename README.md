# My dotfiles

This repository contains the dotfiles for my systems

## Requirements

Ensure you have the following installed on your system

### Git

```
$ sudo apt install git
```

### Stow

```
$ sudo apt install stow
```

## Installation

First, check out the dotfiles repo in your $HOME director using git

```
$ git clone git@github.com/ysereckissy/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```




