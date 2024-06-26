# Dev environment cookbook


## Load your setup

- Adding this to ~/.bashrc

```bash
# dev_folder should be where you put all the repos
export dev_folder=[path_to]/orbuluh_repo
source ${env_folder}/bashrc_extra.env
```

## PS1 setting

- potential: [Powerline-shell](https://github.com/b-ryan/powerline-shell)
- Or simpler, just check your git_related.env file for the gitprompt


## Fonts

- [Noto](https://fonts.google.com/noto/specimen/Noto+Serif+TC)
- [Naikai](https://github.com/max32002/naikaifont)
- [D2Coding](https://github.com/naver/d2codingfont)

## WSL quick tips

- C drive is /mnt/c
- :rotating_light: Windows setup :rotating_light: Control Panel -> Region -> Administrative -> Beta: Use Unicode UTF-8 for worldwide language support"
  - (Without this, when you copy utf-8 text with pyperclip, it just turns into garbage...)

### Windows port forward for WSL2 -> Windows host request

- For example, you open Anki on windows, which has add-on AnkiConnect, which listens to port 8765
- If you want to query the endpoint from WSL2, the magic is setting up port forwarding through:

```bash
# run powershell as admin on windows, use port 8765 as example, which is used by AnkiConnect
netsh interface portproxy add v4tov4 listenport=8765 listenaddress=0.0.0.0 connectport=8765 connectaddress=127.0.0.1
```

- The annoying thing is that once you create the port forward, windows will create a [background process iphlpsvc which seems to be using the port (in fact, it's the port forward netsh binding the port under the hood.](https://superuser.com/a/1729731). Your original app (like AnkiConnect) might not be able to bind the port again after reopening.
- What you can do is remove the port forward first, reopen app, then bind the port again.

```bash
# remove the above port forward rule first
netsh interface portproxy delete v4tov4 listenport=8765 listenaddress=0.0.0.0

# run above add  port forward command again once you reopen your app
```

## Windows install git

- The one on Microsoft App Store might be old (and create some annoying warning, for example)
- Can find the latest in <https://github.com/git-for-windows/git/releases>

## Debian distribution

```
sudo apt upgrade
sudo apt update
sudo apt install -y silversearcher-ag tree clang clang-format wget \
                    python3 python3-pip npm
```

## PS1 setting

- potential: [Powerline-shell](https://github.com/b-ryan/powerline-shell)
- Or simpler, just check your git_related.env file for the gitprompt

## Load your setup

- Adding this to ~/.bashrc

```bash
# dev_folder should be where you put all the repos
export dev_folder=~/orbuluh_repo
export env_folder=${dev_folder}/js_dev_env
export key_base_dir=${dev_folder}/keys
source ${env_folder}/bashrc_extra.env
```

## Remote connection X11 forwarding to vscode Remote ext

- Say on your Windows, you use vscode's Remote ext to connect to a linux host, and you want to open GUI apps on the linux host and display it on your Windows machine.

- [https://zhuanlan.zhihu.com/p/461378596](check this guide)

> 1. On Windows local machine

- To enable X11 Forwarding, the following two lines should be added to ssh config file `C:\Users\[user]\.ssh\config` (This is also the config that the Remote ext will use)

```bash
ForwardX11 yes
ForwardX11Trusted yes
```

- 2. Download & install X11 server like VcXsrv, Xming, etc. Use VxServ as example here

> Remote host

- 3. Usually, the $DISPLAY variable is set on remote host by default when you have configured the ssh config on your Windows localhost On remote host, you should see something like

```bash
> echo $DISPLAY
localhost:10.0

# remember the number from output, for example here, 10
```

- If the output is blank, you should set the $DISPLAY value by yourself.

```bash
export DISPLAY=localhost:10.0
```

> Back to local Windows host

- 4. Run VcXsrv, where the display number should be the value you get from previous Step 3.1, for example, 10 above
- 5. Tick Disable access control and start the VxServ

> Back to remote host

- Run xeyes and see if it's forwarding to your local Windows

## X11 apps/Chrome on WSL2 and display on local windows

- Needs to install one browser in WSL2 so google-auth can work
  - (otherwise there will be error when auth2 try to open page)

```bash
sudo apt install x11-apps -y
cd /tmp
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install --fix-broken -y
```

## vim

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

## (latest) cmake

- From [StackOverflow](https://askubuntu.com/a/865294/1660211)

```bash
# if you installed through official site with previous version, remove it
sudo apt remove --purge --auto-remove cmake

## tweak to latest listed in https://cmake.org/download/ which has title
## Latest Release ($version.$build) that you can modify here
version=3.26
build=4
#-----------------------------------
mkdir ~/temp
cd ~/temp
wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz
tar -xzvf cmake-$version.$build.tar.gz
cd cmake-$version.$build/
./bootstrap
make -j$(nproc)
sudo make install
cmake --version # confirm if it's good, then...
# cd && rm -rf ~/temp

# In addition...
sudo apt-get install pkg-config
```

## [gcc, g++, clang, clang++ to a newer version](https://azrael.digipen.edu/~mmead/www/mg/update-compilers/index.html)

**step 1: add ppa and install newer version first**

```bash
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
# bunch of options
sudo apt-get install list "g\+\+\-1.$" "clang\-1.$" "gcc-1.$"
# select the new version you prefer ...
sudo apt-get install gcc-13 g++-12 clang-15
```

**step 2: make the symlink actually work together**

```bash
# gcc-9 is what ubuntu originally defined
# check `ll /usr/bin/gcc` and you will see what it is
# --slave: This option is used to add slave links to the main command or program.

# we set alternative option of originally gcc-11/g++-11 as priority 50
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 50 --slave /usr/bin/g++ g++ /usr/bin/g++-11

# then we set alternative option of new gcc-13/g++-12 as priority 60
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 60 --slave /usr/bin/g++ g++ /usr/bin/g++-12

# run `sudo update-alternatives --config gcc` to verify
# you will see the auto mode is taking the one with higher priority
# and it's also what you are using

# same logic for clang. Originally it was clang-14, set as priority 50
# install the clang-15 and then set with a higher priority
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-14 50 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-14
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 60 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-15
# we can also verify through `sudo update-alternatives --config clang`
```

## (latest) Boost

**Step 1: Download source**

- [Search Downloads in boost homepage](https://www.boost.org/)
- Extract downloaded file, using 1_82_0 as example

```bash
cd
wget https://boostorg.jfrog.io/artifactory/main/release/1.82.0/source/boost_1_82_0.tar.bz2
bzip2 -d boost_1_82_0.tar.bz2
tar xvf  boost_1_82_0.tar
cd boost_1_82_0
./bootstrap.sh --prefix=/usr/
sudo ./b2 install # don't forget sudo!!
cd && sudo rm -rf boost_1_82_0*
```

(Then your boost CMakeList query should be able to find it! Check repo cpp/boost)

## perf

- check [stackoverflow](https://stackoverflow.com/a/74361501/4924135)

> script /usr/bin/perf always trying to get the perf binary from `uname -r`
> We could replace /usr/bin/perf with the actual perf ...

```bash
sudo apt install linux-tools-lowlatency-hwe-22.04

# then you need to relink /usr/bin/perf (check above)
sudo mv /usr/bin/perf /usr/bin/perf.bk
sudo ln -s /usr/lib/linux-tools/5.15.0-56-lowlatency/perf /usr/bin/perf
```

Side note:

> It is expected the hardware/cache counters are not available on WSL2

> WSL2 runs inside a VM. For HW PMU events to work, the VM + hypervisor would need to support it, so it doesn't let you profile stuff outside of guest VM.

## [bazel](https://bazel.build/install/ubuntu)

```bash
# Note: This is a one-time setup step - if you get "Unable to locate package bazel"
sudo apt install apt-transport-https curl gnupg -y
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list

#-----------------------------------------------------------------------
sudo apt update && sudo apt install bazel
bazel --version
```

## [Protobuf]()

```bash
git clone https://github.com/protocolbuffers/protobuf.git
cd protobuf/
git submodule update --init --recursive
mkdir build && cd build && cmake ..

# without `cmake ..` you will get "Cmake Error: could not load cache"!
# also can't just use `cmake ..` ==> those flag cause me few hours to even make official example to build
# (failed in location asking std::string_view, google suggests to add the below flags...)
cmake -DCMAKE_CXX_STANDARD=17 -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE -DABSL_PROPAGATE_CXX_STD=TRUE ..
sudo cmake --build . --target install # need sudo to install the lib
```

## [OneTBB (TBB)](https://github.com/oneapi-src/oneTBB)

```bash
git clone https://github.com/oneapi-src/oneTBB.git
cd oneTBB
mkdir build
cd build
cmake ..
sudo cmake --build . --target install
```

## [zx](https://github.com/google/zx)

```bash
# install node version manager, nvm, otherwise Ubuntu gave old node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# install the latest node for zx
nvm install --latest-npm

# zx script, use javascript to write scripts
npm i zx -g
```
