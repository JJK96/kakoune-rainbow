# Kakoune rainbow

A kakoune plugin like [rainbow](https://github.com/luochen1990/rainbow).

Highlights pairs of parentheses in the same color, recursive pairs are highlighted in a different color.

# Install

Add this plugin to your `autoload` folder.

Or use [plug](https://github.com/andreyorst/plug.kak)
```
plug 'jjk96/kakoune-rainbow'
```

# Usage

execute `:rainbow` to highlight the current buffer.

execute `:rainbow-disable` to remove the highlighter

# Customization

You can override the `rainbow_colors` option to set your own colors.

Example:
```
set-option global rainbow_colors "rgb:ff0000" "rgb:00ff00" "rgb:0000ff"
```

You can also override the `rainbow_opening` option to set the opening parentheses regex.
Example:
```
set-option global rainbow_opening "[\[{(<]"
```
