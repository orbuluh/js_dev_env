
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

# vim

Just use [The Ultimate vimrc](https://github.com/amix/vimrc)

```bash
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
```

Adding plugin with The ultimate vimrc config:

```bash
# git clone the pulgin
cd ~/.vim_runtime/sources_non_forked/
git clone https://github.com/rhysd/vim-clang-format.git

# Then it's basically good to use. But to make it more convenient, you can add to local config file:
echo "map <F2> :ClangFormat<CR>" >> ~/.vim_runtime/my_configs.vim

# Then whenever you press F2, it do the :ClangFormat
```

# [gcc, g++, clang, clang++ to a newer version](https://azrael.digipen.edu/~mmead/www/mg/update-compilers/index.html)

## step 1: add ppa and install newer version first

```bash
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
# bunch of options
sudo apt-get install list g++* clang*
# select the new version you prefer ...
sudo apt-get install gcc-10 g++-10 clang-15
```
## step 2: make the symlink actually work together

```bash
# gcc-9 is what ubuntu originally defined
# check `ll /usr/bin/gcc` and you will see what it is
# here we set alternative option of originally gcc-9 as priority 50
# then we set alternative option of new gcc-10 as priority 60
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 50 --slave /usr/bin/g++ g++ /usr/bin/g++-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 60 --slave /usr/bin/g++ g++ /usr/bin/g++-10
# run `sudo update-alternatives --config gcc` to verify
# you will see the auto mode is  taking the one with higher priority
# and it's also what you are using

# same logic for clang. Originally it was clang-10, set as priority 50
# install the clang-15 and then set with a higher priority
# we can also verify through `sudo update-alternatives --config clang`
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-10 50 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-10
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 60 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-15
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