# Kakoune rainbow

A kakoune plugin like [rainbow](https://github.com/luochen1990/rainbow).

Highlights pairs of parentheses in the same color, recursive pairs are highlighted in a different color.

# Better alternatives

This plugin is a first prototype, later others have made faster and better implementations.
It's better to use one of the below plugins instead of this one.

- https://github.com/listentolist/kakoune-rainbow
- https://github.com/Bodhizafa/kak-rainbow
- https://github.com/crizan/kak-rainbower

View the discuss thread [here](https://discuss.kakoune.com/t/highlight-all-pairs-rainbow/811/17)

# Install

Add this plugin to your `autoload` folder.

Or use [plug](https://github.com/andreyorst/plug.kak)
```
plug 'jjk96/kakoune-rainbow'
```

# Usage

execute `:rainbow` to highlight the current buffer once.

execute `:rainbow-enable` to highlight the current buffer continuously (note that this may be a bit laggy).

execute `:rainbow-disable` to remove the highlighter

# Configuration

The `rainbow_highlight_background` option sets whether the background of the part between braces should be highlighted.

# Customization

You can override the `rainbow_faces` option to set your own faces.

Example:
```
set-option global rainbow_faces "rgb:ff0000" "rgb:00ff00" "rgb:0000ff"
```

You can also override the `rainbow_opening` option to set the opening parentheses regex.
Example:
```
set-option global rainbow_opening "[\[{(<]"
```
