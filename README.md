# Dev environment cookbook

## WSL quick tips

- C drive is /mnt/c
- git credential needs your windows to install git-bash, then in wsl linux prompt, do:

```bash
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe"

# so that git will show unicode correctly in its message
# git config --global core.quotePath false
git config --global core.quotePath false
```

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

## Debian distribution

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
```

## [gcc, g++, clang, clang++ to a newer version](https://azrael.digipen.edu/~mmead/www/mg/update-compilers/index.html)

**step 1: add ppa and install newer version first**

```bash
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
# bunch of options
sudo apt-get install list g++* clang*
# select the new version you prefer ...
sudo apt-get install gcc-10 g++-10 clang-15
```

**step 2: make the symlink actually work together**

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

## (latest) Boost

**Step 1: Download source**

- [Search Downloads in boost homepage](https://www.boost.org/)
- Extract downloaded file, using 1_81_0 as example

```bash
bzip2 -d boost_1_81_0.tar.bz2
tar xvf  boost_1_81_0.tar
cd boost_1_81_0
./bootstrap.sh --prefix=/usr/
sudo ./b2 install # don't forget sudo!!
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