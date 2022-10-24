
# WSL quick tips

- C drive is /mnt/c
- git credential needs your windows to install git-bash, then in wsl linux prompt, do:

```
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe"
```

# Debian distribution

```
sudo apt-get upgrade
sudo apt-get update
sudo apt-get install clang
sudo apt-get install clang-format
sudo apt-get install cmake
sudo apt-get install wget ca-certificates
sudo apt-get install python3 python3-pip
sudo apt-get install npm
```

# RHEL distribution

```
```

# vim

```
mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/undo
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s $PATH_TO_GIT_REPO/js_dev_env/vimrc ~/.vimrc
```

# [zx](https://github.com/google/zx)

```
# install node version manager, nvm, otherwise Ubuntu gave old node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# install the latest node for zx
nvm install --latest-npm

# zx script, use javascript to write scripts
npm i zx -g
```