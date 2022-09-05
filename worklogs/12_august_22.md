# Worklog

-- kw

## Aim

To locate all environment packages- conda, stack and venv- in `/home/shared`. The environment packages should be accessible by all users.

## Background

### Where Are Environments Currently Located?

- Miniconda: 
    - $HOME/miniconda3/lib (C packages)
    - $HOME/miniconda3/lib/site-packages
    - envs: $HOME/miniconda3/envs

- Stack:
    - Stack environments are stored in the directory specified by $STACK_ROOT
    - $STACK_ROOT usually points to `$HOME/.stack`
    - Stack cannot access `/home/shared/.stack` because of error `parent directory / is not owned by user`

- Virtualenv
    - `venv` files are located in specified directory
    - Can be put wherever, as long as the user has read/write permissions
