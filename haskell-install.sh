#!/bin/bash

if_exists () {
	exists=`which $1`
	if [ -z "$exists" ]
	then
      		echo "$1 installing..."
		sudo apt install $1
	else
      		echo "$1 already installed"
	fi
}

# install necessary preceeding libraries
if_exists make
if_exists curl

# -------- install ghc -------------

GHC_VERSION=8.8.4
DEB_VERSION=9
GHC_DIR="ghc-$GHC_VERSION"
GHC_BINARY_FILE="ghc-$GHC_VERSION-x86_64-deb$DEB_VERSION-linux.tar.xz"

if [ ! -d "$HOME/.local/$GHC_DIR" ]
then
	echo "Installing GHC-$GHC_VERSION to location $HOME/.local/$GHC_DIR"
	cd ~/.local
        wget https://downloads.haskell.org/~ghc/$GHC_VERSION/$GHC_BINARY_FILE
        tar -xf $GHC_BINARY_FILE
        rm $GHC_BINARY_FILE

else
	echo "GHC directory already exists"
fi

ghc_exists=`which ghc`
if [ -z "$ghc_exists" ]
then
	echo "Building and installing GHC..."
	cd $HOME/.local/$GHC_DIR	
	./configure
	sudo make install
else
	echo "GHC already installed"
fi

echo `ghc --version`

# -------------- install cabal -----------------

CABAL_VERSION=3.2.0.0
CABAL_DIR="Cabal-3.2.0.0"

if [ ! -d "$HOME/.local/$CABAL_DIR" ]
then
        echo "Installing Cabal-$CABAL_VERSION to location $HOME/.local/$CABAL_DIR"
        cd ~/.local
        wget https://downloads.haskell.org/~cabal/$CABAL_DIR/$CABAL_DIR.tar.gz
        tar -xvzf $CABAL_DIR.tar.gz
        rm $CABAL_DIR.tar.gz

else
        echo "Cabal directory already exists"
fi

install_cabal () {
	echo "Building and installing Cabal..."
	cd $HOME/.local/$CABAL_DIR
	ghc -threaded --make Setup
	./Setup configure
	./Setup build
	sudo ./Setup install
}

if [ -d "/usr/local/lib/x86_64-linux-ghc-$GHC_VERSION" ]
then
        res=$(ls /usr/local/lib/x86_64-linux-ghc-8.8.4/ | grep "^Cabal-3.2.0.0")
	if [ -z $res ]
        then
		install_cabal
        else
                echo "Cabal already installed"
        fi
else
        install_cabal
fi


# ----------- installing cabal-install ----------------

CABAL_INSTALL_DIR="cabal-install-$CABAL_VERSION"
CABAL_INSTALL_PACKAGE="$CABAL_INSTALL_DIR-x86_64-unknown-linux.tar.xz"

if [ ! -f "$HOME/.local/cabal" ]
then
        echo "Installing cabal-install-$CABAL_VERSION to location $HOME/.local/"
        cd ~/.local
        wget https://downloads.haskell.org/~cabal/$CABAL_INSTALL_DIR/$CABAL_INSTALL_PACKAGE
        tar -xf $CABAL_INSTALL_PACKAGE
        rm $CABAL_INSTALL_PACKAGE

else
        echo "cabal-install executable already exists"
fi

echo "To access cabal, run the following command:"
echo "export PATH=\$HOME/.local:\$PATH"

# -------------- installing stack --------------------------

stack_exists=`which stack`
if [ -z "$stack_exists" ]
then
        echo "Building and installing Haskell-Stack..."
        curl -sSL https://get.haskellstack.org/ | sh
else
        echo "Haskell-Stack already installed"
fi

echo `stack --version`
