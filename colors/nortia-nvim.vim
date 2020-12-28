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
            require('lush')(require('lush_theme.nortia-nvim'))

            if vim.g.airline_theme ~= "" then
                vim.call("airline#load_theme")
            end

            if nortia.is_dark() then
                vim.api.nvim_exec("let $BAT_THEME = g:nortia_bat_dark_theme", false)
            else
                vim.api.nvim_exec("let $BAT_THEME = g:nortia_bat_light_theme", false)
            end

        end

        -- setup re-call
        vim.defer_fn(bang, 1000)
    end
  end
  vim.defer_fn(bang, 100)
EOF
