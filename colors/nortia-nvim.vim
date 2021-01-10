" You probably always want to set this in your vim file
set background=dark
let g:colors_name="nortia-nvim"

" By setting our module to nil, we clear lua's cache,
" which means the require ahead will *always* occur.
"
" This isn't strictly required but it can be a useful trick if you are
" incrementally editing your config a lot and want to be sure your themes
" changes are being picked up without restarting neovim.
"
" Note if you're working in on your theme and have lush.ify'd the buffer,
" your changes will be applied with our without the following line.
lua package.loaded['lush_theme.nortia-nvim'] = nil

" include our theme file and pass it to lush to apply
lua require('lush')(require('lush_theme.nortia-nvim'))
lua << EOF
  local bang
  bang = function()
    if vim.g.colors_name == "nortia-nvim" then

        local nortia = require('nortia.theme')

        if nortia.gate() then
            -- clear lua's cache so our module gets to run again
            package.loaded['lush_theme.nortia-nvim'] = nil

            -- pass our theme to lush to apply
            local theme = require('lush_theme.nortia-nvim')
            require('lush')(theme)

            if vim.g.airline_theme ~= nil then
                vim.call("airline#load_theme")
            end

            if nortia.is_dark() then
                vim.api.nvim_exec("let $BAT_THEME = g:nortia_bat_dark_theme", false)
            else
                vim.api.nvim_exec("let $BAT_THEME = g:nortia_bat_light_theme", false)
            end

            local lualine = require('lualine')
            if lualine ~= nil then
                local nortiall = {  }
                nortiall.normal = {
                    a = {
                        bg = theme.Palette1.fg.hex,
                        fg = theme.Back1.bg.hex,
                    },
                    b = {
                        bg = theme.Back4.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    },
                    c = {
                        bg = theme.Back2.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    }
                }
                nortiall.insert = {
                    a = {
                        bg = theme.Palette2.fg.hex,
                        fg = theme.Back1.bg.hex,
                    },
                    b = {
                        bg = theme.Back4.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    },
                    c = {
                        bg = theme.Back2.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    }
                }
                nortiall.visual = {
                    a = {
                        bg = theme.Palette3.fg.hex,
                        fg = theme.Back1.bg.hex,
                    },
                    b = {
                        bg = theme.Back4.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    },
                    c = {
                        bg = theme.Back2.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    }
                }
                nortiall.replace = {
                    a = {
                        bg = theme.Palette4.fg.hex,
                        fg = theme.Back1.bg.hex,
                    },
                    b = {
                        bg = theme.Back4.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    },
                    c = {
                        bg = theme.Back2.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    }
                }
                nortiall.command = {
                    a = {
                        bg = theme.Palette6.fg.hex,
                        fg = theme.Back1.bg.hex,
                    },
                    b = {
                        bg = theme.Back4.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    },
                    c = {
                        bg = theme.Back2.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    }
                }
                nortiall.terminal = nortiall.normal
                nortiall.inactive = {
                    a = {
                        bg = theme.Back2.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    },
                    b = {
                        bg = theme.Back2.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    },
                    c = {
                        bg = theme.Back2.bg.hex,
                        fg = theme.Fore4.fg.hex,
                    },
                }
                lualine.theme = nortiall
                lualine.status()
            end
        end

        -- setup re-call
        vim.defer_fn(bang, 1000)
    end
  end
  vim.defer_fn(bang, 100)
EOF
