# Make Everything Global

This is a tutorial on how to use global-level installs of common package managers like `stack`, `conda` etc., so that you don't have multiple local installs taking up space on a PC.

## Using Stack Globally

`haskell-stack` already installs as global user. Normally, the `.stack` directory is in `$HOME/.stack`. 

To avoid this, set the `STACK_ROOT` environment variable in your `.bashrc` to your desired `.stack` location. For example:

```
export STACK_ROOT="/shared/.stack"
```

Remember to run `source .bashrc` before running any stack installation! You can see where the current stack root is located by running the following command inside a stack project directory:

```
stack path --stack-root
```