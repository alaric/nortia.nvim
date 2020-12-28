# nortia.nvim - temporal colour scheme for neovim

_This is neovim only, this will not work with legacy vim_

Nortia is designed as a very configurable colour scheme, which by default
changes colour during the day. In daylight hours it's a light colourscheme with
configurable contrast, and at night it's a dark colourscheme. I built this
because I found myself preferring a light colourscheme when my office was
bright, but it was too jarring when in lower light conditions. Since using this
for a while, as it changes on the hour, it's also useful for keeping track of
the time. The colourscheme is made with
[lush.nvim](https://github.com/rktjmp/lush.nvim) as the base, and uses the
[Oklab](https://bottosson.github.io/posts/oklab/#the-oklab-color-space)
perceptual colour space in order to determine some complementary colours for
syntax highlighting. The colours picked are designed to be spread across the
various hues, such that they are complementary to each other and of equal
luminence.

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

## Red and Blue Shifts

## Changing the Base

## Integration with `bat`

The theme supports [bat](https://github.com/sharkdp/bat) being used inside the
neovim instance, such as fzf previews. These variables can be set to change the
bat theme as the Nortia theme changes from light to dark through the day.

- `g:nortia_bat_light_theme`: Set as light background bat theme
- `g:nortia_bat_dark_theme`: Set as dark background bat theme

