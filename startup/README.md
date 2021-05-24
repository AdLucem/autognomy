# startup

A set of haskell-turtle scripts to be run to initialize a fresh Ubuntu-Gnome account with everything needed.

## Set up a fresh PC

Once you have a new PC running Ubuntu (18.04+) and Gnome, you probably want to set it up. Install your programming languages, frequently-used programs, make it look pretty, install gnome shell extensions like Caffeine, etc..

`startup` does (most of) that for you. (no, it actually doesn't tho)

Steps to do this:

1. Installing required programs
2. Modifying settings
3. Installing shell extensions

## Set up a new account on an existing PC

If you want to add a new account to a PC that's already running linux, with all the bells and whistles and frills, `startup` will also do that for you. (once again, it will actually not. but I wish it would)

Steps to do this:

1. Setting up new user account w/sudo privileges
2. Logging into new user account
3. Steps 2 and 3 from previous

## Run

`stack run startup <path_to_config_dir>`

The `config_dir` you specify must have the following files:

- `installs.txt`
- `extensions.sh`
- `run_custom.txt`
- any shell files mentioned in `run_custom.txt`

