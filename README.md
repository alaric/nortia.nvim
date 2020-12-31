# nortia.nvim - temporal colour scheme for neovim

_This is neovim only, this will not work with legacy vim_

## Preview

<img width="260" alt="thumbnail-nortia-light" src="https://user-images.githubusercontent.com/311857/103355173-8963a400-4aa5-11eb-9b16-56bad2959efb.png"><img width="260" alt="thumbnail-nortia-middle" src="https://user-images.githubusercontent.com/311857/103355232-a8facc80-4aa5-11eb-9781-b267f5889193.png"><img width="260" alt="thumbnail-nortia-dark" src="https://user-images.githubusercontent.com/311857/103355238-adbf8080-4aa5-11eb-8a84-6b130acae5af.png">

## What is it

Nortia is designed as a configurable and dynamic colour scheme, which by
default changes colour during the day. In daylight hours it's a light
colourscheme with configurable contrast, and at night it's a dark colourscheme.
I built this because I found myself preferring a light colourscheme when my
office was bright, but it was too jarring when in lower light conditions. Since
using this for a while, as it changes on the hour, it's also useful for keeping
track of the time. The colourscheme is made with
[lush.nvim](https://github.com/rktjmp/lush.nvim) as the base, and uses the
[Oklab](https://bottosson.github.io/posts/oklab/#the-oklab-color-space)
perceptual colour space in order to determine some complementary colours for
syntax highlighting. The colours picked are designed to be spread across the
various hues, such that they are complementary to each other and of equal
luminence.

## Installing

This requires [lush.nvim](https://github.com/rktjmp/lush.nvim) to be installed
also, so with a plugin manager such as
[vim-plug](https://github.com/junegunn/vim-plug) it should just be:

```vim
Plug 'rktjmp/lush.nvim'
Plug 'alaric/nortia.nvim'


color nortia-nvim
```

## Light and Dark

The colour scheme uses the same basic palette of colours for the syntax
elements when using both light and dark backgrounds, however they can be
adjusted differently according to the background. For instance the background
accent colours are changed to be darker than the light background, and lighter
than the dark background.

Although the scheme automatically changes on the hour throughout the day, this
can of course be overriden to suit your conditions.

To set to 1am (dark):
```
:lua require('nortia.theme').set_hour(1)
```

To set to 10am (light):
```
:lua require('nortia.theme').set_hour(10)
```

To set to 4pm (inbetween):
```
:lua require('nortia.theme').set_hour(16)
```

To reset to automatically changing on the hour:
```
:lua require('nortia.theme').set_hour(-1)
```

## Automatic contrast 

The colorscheme automatically adjusts the primary palette to ensure a minimum
contrast ratio is achieved. This is usually most difficult on the lighter
backgrounds, where colours have to be darkened to produce the intended ratio.
I've defaulted it to `2.5` which seems to work well for me, but is far from
the W3C standard of `4.5`.

If the default threshold is not sufficient for you, the contrast threshold can be configured like:

```
:lua require('nortia.theme').set_contrast_threshold(3.5)
```

## Tinting

This allows the foreground or background or both to be tinted with a colour for
those who prefer a slightly coloured rather than greyscale bg/fg.

```
:lua require('nortia.theme').tint_bg(190, 0.1)
:lua require('nortia.theme').tint_fg(190, 0.1)
:lua require('nortia.theme').tint(190, 0.1)
```

The first parameter is the 0-360 hue in degress, the second is the chroma from
Oklab. The lightness is derived from the hour of the day.

<img width="300" alt="thumbnail-nortia-redshift" src="https://user-images.githubusercontent.com/311857/103355250-b617bb80-4aa5-11eb-92f1-d0cabb51c16d.png">

```:lua require('nortia.theme').tint_bg(0, 0.05)```

<img width="300" alt="thumbnail-nortia-blueshift" src="https://user-images.githubusercontent.com/311857/103355253-b9ab4280-4aa5-11eb-8742-045181db19e2.png">

```:lua require('nortia.theme').tint_bg(190, 0.1)```

## Changing the Base

```
:lua require('nortia.theme').set_base(r, g, b)
```

This sets the base colour with the `r, g, b` parameters (0-255), the default
value is `255, 189, 60` if you want to return to normal.

<img width="300" alt="thumbnail-nortia-basechanged" src="https://user-images.githubusercontent.com/311857/103355265-bf088d00-4aa5-11eb-9dfe-686762cbf01a.png">

The above preview was generated with:
```
:lua require('nortia.theme').set_base(235, 84, 84)
```

## Integration with `bat`

The theme supports [bat](https://github.com/sharkdp/bat) being used inside the
neovim instance, such as fzf previews. These variables can be set to change the
bat theme as the Nortia theme changes from light to dark through the day.

- `g:nortia_bat_light_theme`: Set as light background bat theme
- `g:nortia_bat_dark_theme`: Set as dark background bat theme

## Status

The base of the colour scheme is complete in terms of functionality, but it
still needs some tweaking for TreeSitter and different language
syntaxes/plugins. This might lead to some colours in the palette still changing.

