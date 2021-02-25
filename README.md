# autognomy

This is an assorted collection of ubuntu and gnome-shell-based workflow, organization or decoration tools, written in haskell.

## Installation

  - **Step 1** : install git: 
```
$ sudo apt update
$ sudo apt install git
```

  - **Step 2** : install the language (haskell, ghc-8.8.4) and build system (cabal-3.2.0.0, haskell-stack) for this tool:

```
$ ./haskell_install.sh
```

  - **Step 3** : build. For the build system, instead of building it as a cabal project, we decided to use `stack` and build each subproject individually. This is because cabal was going through weird version problems while this code was written. Anyway, there is a build script: 

```
$ ./build.sh
```
		 
## `startup`

[Guide here](startup/README.md)

### Set up a fresh PC

Once you have a new PC running Ubuntu (18.04+) and Gnome, you probably want to set it up. Install your programming languages, frequently-used programs, make it look pretty, install gnome shell extensions like Caffeine, etc..

`startup` does (most of) that for you.

### Set up a new account on an existing PC

If you want to add a new account to a PC that's already running linux, with all the bells and whistles and frills, `startup` will also do that for you.

## \#aesthetic

\#aesthetic is a command-line application that automatically sets the "aesthetic" or look for your Gnome desktop and utilities, as you want it.

Each "aesthetic"- your desktop look- should be defined as a JSON file, that currently contains the following fields:

* wallpaper 
* gtk-theme
* shell-theme
* icon-theme 

The application only works if you have the themes, icon themes et cetera already on your PC- the assumption is that you have a bunch of predefined "looks", defined in the `aesthetic` files, and the application allows you to change between looks at a single click.

Example aesthetics are in [./pretty/](./pretty)

### Usage

```bash
$ ./build.sh
$ ./aesthetic.sh <path-to-json-file>
```

## project-manager

To get a list of all the repositories on your computer, with VCS name (github or gitlab) and account username, run:

```bash
$ cd project-manager
$ stack setup
$ stack build
$ stack exec project-manager
``` 

## Last Worked On

- 26/1/21:
    `startup/src/Main.hs` : trying to get proper argument parsing done
