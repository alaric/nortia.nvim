--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

local lush = require('lush')
local hsl = lush.hsl
local nortia = require('nortia.theme')

function fg_offset (colour, amount)
    if nortia.is_dark() then
        return colour.darken(amount)
    else
        return colour.lighten(amount)
    end
end

function bg_offset (colour, amount)
    if nortia.is_dark() then
        return colour.lighten(amount)
    else
        return colour.darken(amount)
    end
end

local fg_offset = fg_offset
local bg_offset = bg_offset
local g = vim.g

function good(colour)
    return colour.hue(115).saturate(30)
end

function bad(colour)
    return colour.hue(0).saturate(30)
end

function bad_soft(colour)
    return colour.hue(0).saturate(10)
end

function warn(colour)
    return colour.hue(30).saturate(30)
end

function neutral(colour)
    return colour.hue(59).saturate(30)
end

local get_hour = get_hour
local bg_colour = bg_colour
local fg_colour = fg_colour
local good = good
local bad = bad
local bad_soft = bad_soft
local warn = warn
local neutral = neutral
local base = base

local theme = lush(function()
  return {
    Black { fg = hsl(0, 0, 0) },
    White { fg = hsl(0, 0, 100) },
    Green { fg = hsl("#00ff00") },
    Blue { fg = hsl("#0000ff") },
    Red { fg = hsl("#ff0000") },

    Fore1 { fg = hsl(nortia.fg()) },
    Fore2 { fg = fg_offset(Fore1.fg, 10) },
    Fore3 { fg = fg_offset(Fore2.fg, 10) },
    Fore4 { fg = fg_offset(Fore3.fg, 10) },
    Fore5 { fg = fg_offset(Fore4.fg, 10) },
    
    Back1 { bg = hsl(nortia.bg()) },
    Back2 { bg = bg_offset(Back1.bg, 3) },
    Back3 { bg = bg_offset(Back2.bg, 3) },
    Back4 { bg = bg_offset(Back3.bg, 3) },
    Back5 { bg = bg_offset(Back4.bg, 3) },

    Good { fg = good(Fore3.fg), bg = good(Back3.bg) },
    Bad { fg = bad(Fore3.fg), bg = bad(Back3.bg) },
    Neutral { fg = neutral(Fore3.fg), bg = neutral(Back3.bg) },
    Warn { fg = warn(Fore3.fg), bg = warn(Back3.bg) },

    Highlighter { fg = Black1.fg, bg = hsl("#fcf7bb") },

    Palette1 { fg = hsl(nortia.palette()) },
    Palette2 { fg = hsl(nortia.palette(function (x) return nortia.rotate(x, -45) end)) },
    Palette3 { fg = hsl(nortia.palette(function (x) return nortia.rotate(x, 30) end)) },
    Palette4 { fg = hsl(nortia.palette(function (x) return nortia.rotate(x, -75) end)) },
    Palette5 { fg =  hsl(nortia.palette(function (x) return nortia.rotate(x, 150) end)) },
    Palette6 { fg = hsl(nortia.palette(function (x) return nortia.rotate(x, 190) end)) },

    Normal       { fg = Fore1.fg, bg = Back1.bg }, -- normal text
    NormalFloat  { fg = Normal.fg }, -- Normal text in floating windows.
    NormalNC     { fg = Normal.fg }, -- normal text in non-current windows
    Comment { fg = Fore4.fg },
    ColorColumn  { fg = Fore1.fg, bg = Back1.bg.hue(0).saturation(20).lighten(10) }, -- TODO used for the columns set with 'colorcolumn'
    -- Conceal      { }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor       { }, -- character under the cursor
    -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn { bg = Back2.bg }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine   { bg = Back2.bg }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory    { fg = Palette5.fg }, -- directory names (and other special names in listings)
    DiffAdd      { fg = Good.fg, bg = Good.bg }, -- diff mode: Added line |diff.txt|
    DiffChange   { fg = Neutral.fg, bg = Neutral.bg }, -- diff mode: Changed line |diff.txt|
    DiffDelete   { fg = Bad.fg, bg = Bad.bg }, -- diff mode: Deleted line |diff.txt| 
    DiffText     { fg = Warn.fg, bg = Warn.bg }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer  { fg = Back1.bg, bg = Back1.bg }, -- filler lines (~) after the end of the buffer.   By default, this is highlighted like |hl-NonText|.
    -- TermCursor   { }, -- cursor in a focused terminal
    -- TermCursorNC { }, -- cursor in an unfocused terminal
    -- ErrorMsg     { }, -- error messages on the command line
    VertSplit    { fg = Back5.bg, bg = Back1.bg }, -- the column separating vertically split windows
    Folded       { fg = Fore2.fg, bg = Back2.bg }, -- line used for closed folds
    FoldColumn   { fg = Fore4.fg, bg = Back2.bg }, -- 'foldcolumn'
    SignColumn   { fg = Fore4.fg, bg = Back2.bg }, -- column where |signs| are displayed
    IncSearch    { fg = DiffChange.fg, bg = DiffChange.bg }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute   { fg = DiffAdd.fg, bg = DiffAdd.bg }, -- |:substitute| replacement text highlighting
    LineNr       { fg = Fore4.fg, bg = Back2.bg }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { fg = Palette1.fg, bg = Back3.bg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    -- MatchParen   { fg = Palette2.fg }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    -- MoreMsg      { }, -- |more-prompt|
    NonText      { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Pmenu        { fg = Fore1.fg, bg = Back3.bg }, -- TODO blend Popup menu: normal item.
    PmenuSel     { fg = Fore1.fg, bg = Back4.bg }, -- TODO blend Popup menu: selected item.
    PmenuSbar    { fg = Pmenu.fg, bg = Pmenu.bg }, -- TODO blend Popup menu: scrollbar.
    PmenuThumb   { fg = Pmenu.fg, bg = Pmenu.bg }, -- TODO blend Popup menu: Thumb of the scrollbar.
    -- Question     { }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine { bg = CursorLine.bg }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search       { fg = Black.fg, bg = Highlighter.bg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    -- SpecialKey   { }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace| SpellBad  Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.  SpellCap  Word that should start with a capital. |spell| Combined with the highlighting used otherwise.  SpellLocal  Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    -- StatusLine   { }, -- status line of current window
    -- StatusLineNC { }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine      { bg = Back3.bg }, -- tab pages line, not active tab page label
    TabLineFill  { fg = Back4.bg }, -- tab pages line, where there are no labels
    TabLineSel   { fg = Back1.bg, bg = Palette1.fg }, -- tab pages line, active tab page label
    Title        { gui = "bold" }, -- titles for output from ":set all", ":autocmd" etc.
    Visual       { bg = Back3.bg }, -- Visual mode selection
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg   { fg = Warn.fg, bg = Warn.bg }, -- warning messages
    Whitespace   { bg = Back4.bg }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    -- WildMenu     { }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant       { fg = Palette5.fg }, -- (preferred) any constant
    -- Character      { }, --  a character constant: 'c', '\n'
    -- Number         { }, --   a number constant: 234, 0xff
    -- Boolean        { }, --  a boolean constant: TRUE, false
    -- Float          { }, --    a floating point constant: 2.3e10

    String         { fg = Palette3.fg }, --   a string constant: "this is a string"

    Identifier     { fg = Fore2.fg }, -- (preferred) any variable name
    Function       { fg = Palette1.fg }, -- function name (also: methods for classes)

    Statement      { fg = Palette2.fg }, -- (preferred) any statement
    -- Conditional    { }, --  if, then, else, endif, switch, etc.
    -- Repeat         { }, --   for, do, while, etc.
    -- Label          { }, --    case, default, etc.
    -- Exception      { }, --  try, catch, throw

    Keyword        { fg = Palette6.fg }, --  any other keyword

    Operator       { fg = Fore1.fg }, -- "sizeof", "+", "*", etc.

    PreProc        { fg = Palette4.fg }, -- (preferred) generic Preprocessor
    -- Include        { }, --  preprocessor #include
    -- Define         { }, --   preprocessor #define
    -- Macro          { }, --    same as Define
    -- PreCondit      { }, --  preprocessor #if, #else, #endif, etc.

    Type           { fg = Palette1.fg }, -- (preferred) int, long, char, etc.
    -- StorageClass   { }, -- static, register, volatile, etc.
    -- Structure      { }, --  struct, union, enum, etc.
    -- Typedef        { }, --  A typedef

    Special        { fg = Palette5.fg }, -- (preferred) any special symbol
    -- SpecialChar    { }, --  special character in a constant
    -- Tag            { }, --    you can use CTRL-] on this
    -- Debug          { }, --    debugging statements

    Delimiter      { fg = Fore2.fg }, --  character that needs attention
    SpecialComment { fg = Fore3.fg }, -- special things inside a comment

    Underlined { gui = "underline" }, -- (preferred) text that stands out, HTML links
    Bold       { gui = "bold" },
    Italic     { gui = "italic" },

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error          { fg = Bad.fg, bg = Bad.bg }, -- (preferred) any erroneous construct
    Todo           { fg = Black.fg, bg = Highlighter.bg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client. Some other LSP clients may use
    -- these groups, or use their own. Consult your LSP client's documentation.

    LspDiagnosticsDefaultError               { fg = Bad.fg, bg = Bad.bg }, -- used for "Error" diagnostic virtual text
    LspDiagnosticsDefaultWarning             { fg = Warn.fg, bg = Warn.bg }, -- used for "Warning" diagnostic virtual text
    LspDiagnosticsDefaultInformation         { fg = Neutral.fg, bg = Neutral.bg }, -- used for "Information" diagnostic virtual text
    LspDiagnosticsDefaultHint                { fg = Neutral.fg, bg = Neutral.bg }, -- used for "Hint" diagnostic virtual text

    DiagnosticError               { fg = Bad.fg, bg = Bad.bg }, -- used for "Error" diagnostic virtual text
    DiagnosticWarn             { fg = Warn.fg, bg = Warn.bg }, -- used for "Warning" diagnostic virtual text
    DiagnosticInfo         { fg = Neutral.fg, bg = Neutral.bg }, -- used for "Information" diagnostic virtual text
    DiagnosticHint                { fg = Neutral.fg, bg = Neutral.bg }, -- used for "Hint" diagnostic virtual text

    -- Custom for linehl if you want to customise the LSP sign for that
    LspDiagnosticsLineError { bg = bad_soft(Back1.bg) },
    DiagnosticLineError { bg = bad_soft(Back1.bg) },

    -- For the TodoComment plugin it generates highlighting themes itself
    -- and they get cleared by the nortia reset. This matches the default set
    -- from the plugin and provides our own highlights
    --
    -- TODO it'd be nice in the future to have these generated from the closest
    -- Palette to a particular red or orange etc
    --
    -- The TODO colouring is the only specialised one here as the higlighter
    -- tone is only good when setting both fg and bg
    TodoBgTODO { fg = Fore1.bg, bg = Highlighter.bg, gui = "bold" },
    TodoFgTODO { fg = Neutral.fg },
    TodoSignTODO { fg = Neutral.fg, bg = Back2.fg },

    TodoBgFIX { fg = Back1.bg, bg = Palette4.fg, gui = "bold" },
    TodoFgFIX { fg = Palette4.fg },
    TodoSignFIX { fg = Palette4.fg, bg = Back2.bg },

    TodoBgWARN { fg = Back1.bg, bg = Palette2.fg, gui = "bold" },
    TodoFgWARN { fg = Palette2.fg  },
    TodoSignWARN { fg = Palette2.fg, bg = Back2.bg },

    TodoBgHACK { fg = Back1.bg, bg = Palette2.fg, gui = "bold" },
    TodoFgHACK { fg = Palette2.fg  },
    TodoSignHACK { fg = Palette2.fg, bg = Back2.bg },

    TodoBgPERF { fg = Back1.bg, bg = Neutral.fg, gui = "bold" },
    TodoFgPERF { fg = Neutral.fg  },
    TodoSignPERF { fg = Neutral.fg, bg = Back2.bg },

    TodoBgNOTE { fg = Back1.bg, bg = Palette6.fg, gui = "bold" },
    TodoFgNOTE { fg = Palette6.fg  },
    TodoSignNOTE { fg = Palette6.fg, bg = Back2.bg },

    -- These groups are for the neovim tree-sitter highlights.
    -- As of writing, tree-sitter support is a WIP, group names may change.
    -- By default, most of these groups link to an appropriate Vim group,
    -- TSError -> Error for example, so you do not have to define these unless
    -- you explicitly want to support Treesitter's improved syntax awareness.

    TSError              { fg = Error.fg, bg = Error.bg }, -- For syntax/parser errors.
    -- TSPunctDelimiter     { }, -- For delimiters ie: `.`
    -- TSPunctBracket       { }, -- For brackets and parens.
    -- TSPunctSpecial       { }, -- For special punctutation that does not fall in the catagories before.
    -- TSConstant           { }, -- For constants
    -- TSConstBuiltin       { }, -- For constant that are built in the language: `nil` in Lua.
    -- TSConstMacro         { }, -- For constants that are defined by macros: `NULL` in C.
    -- TSString             { }, -- For strings.
    -- TSStringRegex        { }, -- For regexes.
    -- TSStringEscape       { }, -- For escape characters within a string.
    -- TSCharacter          { }, -- For characters.
    -- TSNumber             { }, -- For integers.
    -- TSBoolean            { }, -- For booleans.
    -- TSFloat              { }, -- For floats.
    -- TSFunction           { }, -- For function (calls and definitions).
    -- TSFuncBuiltin        { }, -- For builtin functions: `table.insert` in Lua.
    -- TSFuncMacro          { }, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    -- TSParameter          { }, -- For parameters of a function.
    -- TSParameterReference { }, -- For references to parameters of a function.
    -- TSMethod             { }, -- For method calls and definitions.
    -- TSField              { }, -- For fields.
    -- TSProperty           { }, -- Same as `TSField`.
    -- TSConstructor        { }, -- For constructor calls and definitions: `{ }` in Lua, and Java constructors.
    -- TSConditional        { }, -- For keywords related to conditionnals.
    -- TSRepeat             { }, -- For keywords related to loops.
    -- TSLabel              { }, -- For labels: `label:` in C and `:label:` in Lua.
    -- TSOperator           { }, -- For any operator: `+`, but also `->` and `*` in C.
    -- TSKeyword            { }, -- For keywords that don't fall in previous categories.
    -- TSKeywordFunction    { }, -- For keywords used to define a fuction.
    -- TSException          { }, -- For exception related keywords.
    -- TSType               { }, -- For types.
    -- TSTypeBuiltin        { }, -- For builtin types (you guessed it, right ?).
    -- TSNamespace          { }, -- For identifiers referring to modules and namespaces.
    -- TSInclude            { }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    -- TSAnnotation         { }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    -- TSText               { }, -- For strings considered text in a markup language.
    -- TSStrong             { }, -- For text to be represented with strong.
    -- TSEmphasis           { }, -- For text to be represented with emphasis.
    -- TSUnderline          { }, -- For text to be represented with an underline.
    -- TSTitle              { }, -- Text that is part of a title.
    -- TSLiteral            { }, -- Literal text.
    -- TSURI                { }, -- Any URI like a link or email.
    -- TSVariable           { }, -- Any variable name that does not have another highlight.
    -- TSVariableBuiltin    { }, -- Variable names that are defined by the languages, like `this` or `self`.

    GitGutterAddLineNr { fg = Good.fg, bg = Good.bg },
    GitGutterDeleteLineNr { fg = Bad.fg, bg = Bad.bg },
    GitGutterAdd { fg = Good.fg, bg = Good.bg },
    GitGutterDelete { fg = Bad.fg, bg = Bad.bg },
    GitGutterChange { fg = Neutral.fg, bg = Neutral.bg },

  }
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
