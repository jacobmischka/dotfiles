# Paths
export GOPATH=$HOME/go
export HOMEPATH=$HOME/.local/bin
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROIDPATH=$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
export NPMPATH=$HOME/.npm-global/bin
export YARNPATH=$HOME/.yarn/bin
export CARGOPATH=$HOME/.cargo/bin
export DARTPUBPATH=$HOME/.pub-cache/bin
export PATH=$HOMEPATH:$YARNPATH:$NPMPATH:$CARGOPATH:$GOPATH/bin:$ANDROIDPATH:$DARTPUBPATH:$PATH

export QT_QPA_PLATFORMTHEME="qt5ct"

# Neovim
export NVIM_GTK_PREFER_DARK_THEME=1
export NVIM_GTK_NO_HEADERBAR=1

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

if [ -f ~/.profile.local ]; then
	source ~/.profile.local
fi
