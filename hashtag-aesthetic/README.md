# \#aesthetic

This is a bunch of gnome shell commands, wrapped in haskell, that changes your (gnome) desktop to your preferred:

* theme (stored in your google drive folder)
* shell theme (stored in your google drive folder)
* icon theme (stored in your google drive folder)
* wallpaper (stored in `autognomy/pretty/pictures`)
* sublime text config files (stored in `autognomy/pretty/<your #aesthetic name>`)

Example aesthetics are in [../pretty/](../pretty)

## Usage

In the home directory, run:

```bash
$ stack build
$ stack run
```

## Pipe Dreams

Functionality I hope to add in the future:

* Automatically download + unzip themes, using `wget` or `curl`, from a specified link. So that I don't have to cart around the `theme.tar.gz` files in my google drive.
* Specify a list of color hex codes, have the program switch between a range of wallpapers (stored in `~/Pictures/Wallpapers`) that have 'dominant' colors in the specified color list.
