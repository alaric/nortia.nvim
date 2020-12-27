#! /usr/bin/env lua
--
-- nortia.lua
-- Copyright (C) 2020 Alaric Nightingale
--
-- Distributed under terms of the MIT license.
--

local oklab = require('nortia.oklab')

local bg_colours = { 14, 14, 18, 18, 22, 22, 22, 22, 94, 96, 96, 98,
                     98, 96, 94, 94, 25, 22, 18, 18, 14, 14, 14, 14 }
local fg_colours = { 84, 84, 88, 88, 84, 84, 84, 84, 35, 35, 35, 35,
                     35, 35, 35, 35, 84, 84, 84, 84, 84, 84, 80, 80 }

local override_hour = -1
local contrast_threshold = 2.5

local function get_hour()
    if override_hour >= 0 then
        return override_hour
    end
    local hour = os.date("*t").hour
    return hour
end

local function set_hour(h)
    override_hour = h
end

local function set_contrast_threshold(t)
    contrast_threshold = t
end

local function is_dark()
    return bg_colours[get_hour() + 1] <= 50
end

local function bg_colour()
    return bg_colours[get_hour() + 1]
end

local function fg_colour()
    return fg_colours[get_hour() + 1]
end

local function base()
    return oklab.rgb_to_polar({ r=235, g=199, b=62 })
end

local function bg_base()
    local grey = 256 * (bg_colour() / 100.0)
    local r = oklab.round_clamped(grey, 0, 255)
    local g = oklab.round_clamped(grey, 0, 255)
    local b = oklab.round_clamped(grey, 0, 255)
    return oklab.rgb_to_polar({ r=r, g=g, b=b })
end

local function fg_base()
    local grey = 256 * (fg_colour() / 100.0)
    local r = oklab.round_clamped(grey, 0, 255)
    local g = oklab.round_clamped(grey, 0, 255)
    local b = oklab.round_clamped(grey, 0, 255)
    return oklab.rgb_to_polar({ r=r, g=g, b=b })
end

local function w3c_luminence_int(c)
    local col = c / 255.0
    if col <= 0.03928 then
        return col / 12.92
    else
        return math.pow(((col + 0.055)/1.044), 2.4)
    end
end

local function w3c_luminence(c)
    local r = w3c_luminence_int(c.r)
    local g = w3c_luminence_int(c.g)
    local b = w3c_luminence_int(c.b)
    return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

local function w3c_contrast(c1, c2)
    local c1 = oklab.oklab_to_rgb(oklab.polar_to_oklab(c1))
    local c2 = oklab.oklab_to_rgb(oklab.polar_to_oklab(c2))   
    local lum1 = w3c_luminence(c1)
    local lum2 = w3c_luminence(c2)
    if lum1 > lum2 then
        return ((lum1 + 0.05) / (lum2 + 0.05))
    else
        return ((lum2 + 0.05) / (lum1 + 0.05))
    end
end

local function palette(f)
    local c = base()

    if f ~= nil then
        c = f(c)
    end

    local contrast = w3c_contrast(c, bg_base())
    while contrast < contrast_threshold do
        if is_dark() then
            c.L = c.L * 1.10
            c.C = c.C * 1.10
        else
            c.L = c.L * 0.9
            c.C = c.C * 1.20
        end
        contrast = w3c_contrast(c, bg_base())
    end

    return oklab.polar_to_hex(c)
end


local function test()
    print(vim.inspect(base()))
    print(vim.inspect(bg_base()))
    print(vim.inspect(fg_base()))
    print(vim.inspect(palette(nil)))
    print(vim.inspect(w3c_contrast(fg_base(), bg_base())))
    print(vim.inspect(w3c_contrast(base(), bg_base())))
end

return {
    rotate = oklab.rotate,
    get_hour = get_hour,
    set_hour = set_hour,
    fg_colour = fg_colour,
    bg_colour = bg_colour,
    is_dark = is_dark,
    base = base,
    palette = palette,
    set_contrast_threshold = set_contrast_threshold,
    test = test,
}