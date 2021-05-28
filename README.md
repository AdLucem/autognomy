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

Note: this is a very incomplete program that is actually just a collection of my programs

`startup` is the one that kinda-maybe-works

`hashtag-aesthetic` works in the sense that it set the theme/shell theme I want, I'm still trying to get it to do my sublime text configs

