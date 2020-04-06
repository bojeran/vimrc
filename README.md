# vimrc
**TAGS**: vimrc, focus on ergonomics, cross platform, ideavim included

## Install under Mac OS X
```bash
# Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install vimrc
git clone https://github.com/bojeran/vimrc.git
cd vimrc
ln -s "$(pwd)/.vimrc" ~/.vimrc
ln -s "$(pwd)/.ideavimrc" ~/.ideavimrc

# Launch vim and run :PluginInstall
```

## Install under Windows
**PART 1 - YouCompleteMe:**
1. Install chocolatley WITH admin rights IN powershell. Whenever you do choco install, do it as admin.
2. Install python, vim, golang, nodejs, cmake WITH choco install. gvim x64 is not available through the official website.
GVIM MUST BE x64 and MUST HAVE python3/dyn SUPPORT compiled which is the default with choco. Also the built in python support for GVIM
MUST match the python version you install PERFECTLY. Which is also something choco does for you.
3. Follow Instructions of the Plugin `YouCompleteMe`. This is not super easy, read carefully.

**PART 2 - Unity 3D:**
1. `Edit > Preferences > External Tools` set External Editor to GVIM.
2. External Script Editor Args: `--remote-tab-silent +$(Line) "$(File)"`.

**PART 3 - vimrc:**
1. Clone this repository and just copy the `.vimrc` file to your home
directory.
2. Run `:PluginInstall` and good luck!
