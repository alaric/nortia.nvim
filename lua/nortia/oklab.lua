#! /usr/bin/env lua
--
-- nortia.lua
-- Copyright (C) 2020 Alaric Nightingale
--
-- Distributed under terms of the MIT license.
--

local function round(number)
    return math.floor(number + 0.5)
end

local function round_clamped(number, min_clamp, max_clamp)
    return math.min(math.max(round(number), min_clamp), max_clamp)
end

local function linear_srgb_to_oklab(c) 
    local l = 0.4121656120 * c.r + 0.5362752080 * c.g + 0.0514575653 * c.b
    local m = 0.2118591070 * c.r + 0.6807189584 * c.g + 0.1074065790 * c.b
    local s = 0.0883097947 * c.r + 0.2818474174 * c.g + 0.6302613616 * c.b

    local l_ = l ^ (1.0 / 3.0)
    local m_ = m ^ (1.0 / 3.0)
    local s_ = s ^ (1.0 / 3.0)

    return {
        L = 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_,
        a = 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_,
        b = 0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_,
    }
end

local function oklab_to_linear_srgb(c) 
    local l_ = c.L + 0.3963377774 * c.a + 0.2158037573 * c.b
    local m_ = c.L - 0.1055613458 * c.a - 0.0638541728 * c.b
    local s_ = c.L - 0.0894841775 * c.a - 1.2914855480 * c.b

    local l = l_ * l_ * l_
    local m = m_ * m_ * m_
    local s = s_ * s_ * s_

    return {
        r = round_clamped(4.0767245293 * l - 3.3072168827 * m + 0.2307590544 * s, 0, 255),
        g = round_clamped(-1.2681437731 * l + 2.6093323231 * m - 0.3411344290 * s, 0, 255),
        b = round_clamped(-0.0041119885 * l - 0.7034763098 * m + 1.7068625689 * s, 0, 255),
    }
end

local function oklab_to_polar(c)
    return {
        L = c.L,
        C = math.sqrt(c.a*c.a + c.b*c.b),
        h = math.atan2(c.b, c.a),
    }
end

local function polar_to_oklab(c)
    return {
        L = c.L,
        a = c.C * math.cos(c.h),
        b = c.C * math.sin(c.h),
    }
end

local function srgb_to_hex(c)
    return string.format('#%02X%02X%02X', c.r, c.g, c.b)
end

local function rgb_to_oklab_polar(c)
    return oklab_to_polar(linear_srgb_to_oklab(c))
end

local function oklab_polar_to_hex(c)
    return srgb_to_hex(oklab_to_linear_srgb(polar_to_oklab(c)))
end

local function test ()
    local col = { r = 255, g = 255, b = 255 }
    print('TEST from lua' .. vim.inspect(oklab_to_linear_srgb(linear_srgb_to_oklab(col))))
    print('TEST from lua' .. vim.inspect(oklab_to_linear_srgb(polar_to_oklab(oklab_to_polar(linear_srgb_to_oklab(col))))))
    local col = { r = 0, g = 0, b = 0 }
    print('TEST from lua' .. vim.inspect(oklab_to_linear_srgb(linear_srgb_to_oklab(col))))
    print('TEST from lua' .. vim.inspect(oklab_to_linear_srgb(polar_to_oklab(oklab_to_polar(linear_srgb_to_oklab(col))))))
    local col = { r = 255, g = 0, b = 0 }
    print('TEST from lua' .. vim.inspect(oklab_to_linear_srgb(linear_srgb_to_oklab(col))))
    print('TEST from lua' .. vim.inspect(oklab_to_polar(linear_srgb_to_oklab(col))))
    local col = { r = 0, g = 255, b = 0 }
    print('TEST from lua' .. vim.inspect(oklab_to_linear_srgb(linear_srgb_to_oklab(col))))
    print('TEST from lua' .. vim.inspect(oklab_to_polar(linear_srgb_to_oklab(col))))
    local col = { r = 0, g = 0, b = 255 }
    print('TEST from lua' .. vim.inspect(oklab_to_linear_srgb(linear_srgb_to_oklab(col))))
    print('TEST from lua' .. vim.inspect(oklab_to_polar(linear_srgb_to_oklab(col))))
    print('Test ' .. srgb_to_hex(col))
    print(oklab_polar_to_hex(rgb_to_oklab_polar({ r=255, g=255, b=255 })))
end

local function oklab_polar_rotate(c, amount)
    return { L = c.L, C = c.C, h = (c.h + ((amount / 360.0) * 2 * math.pi)) }
end

return {
    test = test,
    rgb_to_polar = rgb_to_oklab_polar,
    polar_to_hex = oklab_polar_to_hex,
    polar_to_oklab = polar_to_oklab,
    oklab_to_rgb = oklab_to_linear_srgb,
    round = round,
    round_clamped = round_clamped,
    rotate = oklab_polar_rotate,
}
